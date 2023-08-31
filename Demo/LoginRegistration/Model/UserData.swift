//
//  UserData.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 11/08/2023.
//

import Foundation

struct UserData: Codable {
    let id: Int?
    let roleId: Int?
    let firstName: String?
    let lastName: String?
    let email: String?
    let userName: String?
    let gender: String?
    let phoneNo: String?
    let isActive: Bool?
    let created: String?
    let modified: String?
    let accessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case roleId = "role_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case userName = "username"
        case gender
        case phoneNo = "phone_no"
        case isActive = "is_active"
        case created
        case modified
        case accessToken = "access_token"
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
