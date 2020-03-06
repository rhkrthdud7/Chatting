//
//  ErrorType.swift
//  Chatting
//
//  Created by Soso on 01/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import Foundation

enum ErrorType: Error {
    case none
    case invalidUsername
    case invalidPassword
    case unknown
    
    init(statusCode: Int) {
        switch statusCode {
        case 200...299: self = .none
        case 480:       self = .invalidUsername
        case 481:       self = .invalidPassword
        default:        self = .unknown
        }
    }
    
    var description: String {
        switch self {
        case .none:                 return "None"
        case .invalidUsername:      return "Invalid Username"
        case .invalidPassword:      return "Invalid Password"
        default:                    return "Unknown"
        }
    }
    
}
