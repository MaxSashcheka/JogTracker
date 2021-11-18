//
//  Model.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/17/21.
//

import Foundation


struct JogsResponce: Decodable {
    var response: Response
    var timestamp: TimeInterval
}

struct Response: Decodable {
    var jogs: [Jog]
    var users: [User]
}

struct Jog: Decodable {
    var jogId: Int
    var userId: String
    var distance: Float
    var time: Int
    var date: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case jogId = "id"
        case userId = "user_id"
        case distance
        case time
        case date
    }
}

struct User: Decodable {
    var userId: String
    var email: String
    var phoneNumber: String
    var role: String
    var firstName: String
    var lastName: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case email
        case phoneNumber = "phone"
        case role
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
}
