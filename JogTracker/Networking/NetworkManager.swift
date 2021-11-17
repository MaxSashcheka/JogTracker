//
//  NetworkManager.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/17/21.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://jogtracker.herokuapp.com/api"
    
    private init() {}
    
    func fetchJogs(completed: @escaping (Result<JogsResponce, JTError>) -> Void) {
        
        let endPoint = baseURL + "/v1/data/sync"
        
        let sessionConfig = URLSessionConfiguration.default
        let authValue: String? = "Bearer b01da59cec0de2bea6015d66e966e59dd007778998698388e1983f3116b4bb17"
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
    
    func deleteJog(withId jogId: Int) {
        
        let endPoint = baseURL + "/v1/data/jog"
        
        let sessionConfig = URLSessionConfiguration.default
        let authValue: String? = "Bearer b01da59cec0de2bea6015d66e966e59dd007778998698388e1983f3116b4bb17"
        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue ?? ""]
        let session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)
        
        let parameters = [
            "jog_id": jogId,
            "user_id": "134"
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
    
    
    
}
