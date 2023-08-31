//
//  ErrorResponse.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 10/08/2023.
//

import Foundation

struct DataMissing {
    let status: Int
    let message: String
    let userMsg: String
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case userMsg = "user_msg"
    }
}

struct DataAlreadyExists {
    let status: Int
    let data: [UserData]
    let message: String
    let userMsg: String
    enum CodingKeys: String, CodingKey {
        case status
        case data
        case message
        case userMsg = "user_msg"
    }
}
