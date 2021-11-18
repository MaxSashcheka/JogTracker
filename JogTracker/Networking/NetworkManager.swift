//
//  NetworkManager.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/17/21.
//

import Foundation
import KeychainAccess

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://jogtracker.herokuapp.com/api"

    // MARK: - Get
    
    func fetchJogs(completed: @escaping (Result<JogsResponce, JTError>) -> Void) {
        
        let endPoint = baseURL + "/v1/data/sync"
        
        let keychain = Keychain(service: "com.rollingscopesschoolstudent.JogTracker")
        guard let accessToken = keychain["accessToken"] else { return }
        guard let tokenType = keychain["tokenType"] else { return }
        print(accessToken)
        print(tokenType)
        
        let sessionConfig = URLSessionConfiguration.default
        let authValue: String? = "\(tokenType) \(accessToken)"
        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue ?? ""]
        let session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidEndPoint))
            return
        }
        
        session.dataTask(with: url) { data, responce, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                completed(.failure(.invalidResponce))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let jogResponce = try JSONDecoder().decode(JogsResponce.self, from: data)
                DispatchQueue.main.async {
                    completed(.success(jogResponce))
                }
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    // MARK: - Delete
    
    func deleteJog(withId jogId: Int) {
        
        let endPoint = baseURL + "/v1/data/jog"
        
        let keychain = Keychain(service: "com.rollingscopesschoolstudent.JogTracker")
        guard let accessToken = keychain["accessToken"] else { return }
        guard let tokenType = keychain["tokenType"] else { return }
        guard let userId = keychain["userId"] else { return }
        
        let sessionConfig = URLSessionConfiguration.default
        let authValue: String? = "\(tokenType) \(accessToken)"
        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue ?? ""]
        let session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)
        
        let parameters = [
            "jog_id": jogId,
            "user_id": userId
        ] as [String : Any]
        
        guard let url = URL(string: endPoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            print("Invalid serialization")
            return
        }
        request.httpBody = httpBody
        
        session.dataTask(with: request) { data, responce, error in
            if let _ = error {
                print("Unable to complete")
                return
            }
            
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                print("Invalid responce")
                return
            }
        }.resume()
        
    }
    
    // MARK: - Post
    
    func postJog(_ jogToSave: Jog, completed: @escaping (JTError?) -> Void) {
        
        let endPoint = baseURL + "/v1/data/jog"
        
        let keychain = Keychain(service: "com.rollingscopesschoolstudent.JogTracker")
        guard let accessToken = keychain["accessToken"] else { return }
        guard let tokenType = keychain["tokenType"] else { return }
        
        let sessionConfig = URLSessionConfiguration.default
        let authValue: String? = "\(tokenType) \(accessToken)"
        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue ?? ""]
        let session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)
        
        guard let url = URL(string: endPoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jogDate = Date(timeIntervalSince1970: jogToSave.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let jogDateString = formatter.string(from: jogDate)
    
        let parameters = [
            "date": jogDateString,
            "time": jogToSave.time,
            "distance": jogToSave.distance
        ] as [String : Any]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            completed(.invalidSerialization)
            return
        }
        request.httpBody = httpBody
        
        session.dataTask(with: request) { data, responce, error in
            if let _ = error {
                completed(.unableToComplete)
                return
            }
            
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                completed(.invalidResponce)
                return
            }
        }.resume()
        
    }
    
    // MARK: - Update
    
    func updateJog(_ jogToUpdate: Jog, completed: @escaping (JTError?) -> Void) {
        
        let endPoint = baseURL + "/v1/data/jog"
        
        let keychain = Keychain(service: "com.rollingscopesschoolstudent.JogTracker")
        guard let accessToken = keychain["accessToken"] else { return }
        guard let tokenType = keychain["tokenType"] else { return }
        guard let userId = keychain["userId"] else { return }

        let sessionConfig = URLSessionConfiguration.default
        let authValue: String? = "\(tokenType) \(accessToken)"
        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue ?? ""]
        let session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)
        
        guard let url = URL(string: endPoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jogDate = Date(timeIntervalSince1970: jogToUpdate.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let jogDateString = formatter.string(from: jogDate)
    
        let parameters = [
            "date": jogDateString,
            "time": jogToUpdate.time,
            "distance": jogToUpdate.distance,
            "jog_id": jogToUpdate.jogId,
            "user_id": userId
        ] as [String : Any]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            completed(.invalidSerialization)
            return
        }
        request.httpBody = httpBody
        
        session.dataTask(with: request) { data, responce, error in
            if let _ = error {
                completed(.unableToComplete)
                return
            }
            
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                completed(.invalidResponce)
                return
            }
        }.resume()
        
    }
    
    // Authorization
    
    func authorize(withUUID uuid: String, completed: @escaping (Result<LoginResponce, JTError>) -> Void) {
        
        let endPoint = baseURL + "/v1/auth/uuidLogin"
        guard let url = URL(string: endPoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters = [
            "uuid": uuid,
        ] as [String : Any]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            completed(.failure(.invalidSerialization))
            return
        }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let responce = responce as? HTTPURLResponse else {
                completed(.failure(.invalidResponce))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let loginResponce = try JSONDecoder().decode(LoginResponce.self, from: data)
                completed(.success(loginResponce))
                
            } catch {
                completed(.failure(.invalidData))
            }
            
            
        }.resume()
        
    }
    
    
}
