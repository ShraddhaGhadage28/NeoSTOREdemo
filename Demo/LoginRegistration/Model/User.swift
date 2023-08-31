//
//  File.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 10/08/2023.
//

import Foundation


struct User: Codable  {
    let firstName: String?
    let lastName: String?
    let email: String?
    let password: String?
    let confirmPassword: String?
    let gender: String?
    let phoneNo: Int?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case password
        case confirmPassword = "confirm_password"
        case gender
        case phoneNo = "phone_no"
    }
    
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

//struct RegistrationParameter:Encodable {
//    var firstname: String?
//    var lastName: String?
//    var email: String?
//    var password: String
//}


