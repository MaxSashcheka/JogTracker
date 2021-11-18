//
//  LoginModel.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/18/21.
//

import Foundation

struct LoginResponce: Decodable {
    var response: TokenResponse
    var timestamp: TimeInterval
}

struct TokenResponse: Decodable {
    var accessToken: String
    var tokenType: String
    var expiresIn: Int
    var scope: String
    var createdAt: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case createdAt = "created_at"
    }
}
