//
//  Response.swift
//  Chatting
//
//  Created by Soso on 01/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import Foundation

struct APIResponse<T>: Codable where T: Codable {
    let statusCode: Int
    let message: String
    let data: T?
    
    private enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message = "message"
        case data = "data"
    }
    
}
