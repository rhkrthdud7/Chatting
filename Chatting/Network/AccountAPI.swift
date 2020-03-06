//
//  AccountAPI.swift
//  Chatting
//
//  Created by Soso on 01/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import Foundation
import Moya

enum AccountAPI {
    case login(username: String, password: String)
    case findUsername
    case findPassword(username: String)
}

extension AccountAPI: TargetType {
    var baseURL: URL {
        if let url = URL(string: NetworkManager.baseURL) {
            return url
        } else {
            NSLog("\(type(of: self)): Could not find baseURL")
            fatalError("Could not find baseURL")
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/account/login"
        case .findUsername:
            return "/account/find"
        case .findPassword:
            return "/account/find"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .get
        case .findUsername, .findPassword:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .findUsername:
            return .requestPlain
        case let .login(username, password):
            return .requestParameters(parameters: [
                "username": username,
                "password": password
            ], encoding: JSONEncoding.default)
        case let .findPassword(username):
            return .requestParameters(parameters: [
                "username": username
            ], encoding: JSONEncoding.default)
        }
    }
    
    var sampleData: Data {
        return """
        {
            "status_code": 200,
            "message": "Login succeeded",
            "data": {
                "token": "token"
            }
        }
        """.utf8Encoded
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
