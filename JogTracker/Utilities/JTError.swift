//
//  JTError.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/17/21.
//

import Foundation

enum JTError: String, Error {
    
    case invalidEndPoint        = "This endPoint created an invalid request. Please try again"
    case unableToComplete       = "Unable to complete your request. Please check your internet connection"
    case invalidResponce        = "Invalid responce from the server. Please try again"
    case invalidData            = "The data received from the server was invalid. Please try again."
    case invalidSerialization   = "Can`t serialize dictionary into json object"

}
