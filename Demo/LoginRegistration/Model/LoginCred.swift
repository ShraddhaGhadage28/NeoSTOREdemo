//
//  LoginModel.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 17/08/2023.
//

import Foundation

struct LoginCred:Codable {
    let email: String?
    let password: String?
    
    var asDictionary: [String: Any] {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase  // To match CodingKeys
            guard let jsonData = try? encoder.encode(self) else {
                return [:]
            }
            
            guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
                return [:]
            }
            
            if let dict = jsonObject as? [String: Any] {
                return dict
            } else {
                return [:]
            }
        }
}
