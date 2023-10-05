//
//  GetAccountDetailsModel.swift
//  Demo
//
//  Created by Neosoft on 07/09/23.
//

import Foundation
struct GetAccountDetailsModel : Codable {
    let status : Int?
    let data : Data?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(Data.self, forKey: .data)
    }

}

struct Data : Codable {
    let userData : UserAccountData?
    let productCategories : [ProductCategories]?
    let totalCarts : Int?
    let totalOrders : Int?

    enum CodingKeys: String, CodingKey {

        case userData = "user_data"
        case productCategories = "product_categories"
        case totalCarts = "total_carts"
        case totalOrders = "total_orders"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userData = try values.decodeIfPresent(UserAccountData.self, forKey: .userData)
        productCategories = try values.decodeIfPresent([ProductCategories].self, forKey: .productCategories)
        totalCarts = try values.decodeIfPresent(Int.self, forKey: .totalCarts)
        totalOrders = try values.decodeIfPresent(Int.self, forKey: .totalOrders)
    }

}
struct ProductCategories : Codable {
    let id : Int?
    let name : String?
    let iconImage : String?
    let created : String?
    let modified : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case iconImage = "icon_image"
        case created = "created"
        case modified = "modified"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        iconImage = try values.decodeIfPresent(String.self, forKey: .iconImage)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
    }

}
struct UpdateAccountModel : Codable {
    let status : Int?
    let data : UserAccountData?
    let message : String?
    let userMsg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case message = "message"
        case userMsg = "user_msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(UserAccountData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userMsg = try values.decodeIfPresent(String.self, forKey: .userMsg)
    }
}

struct UserAccountData : Codable {
    let id : Int?
    let roleId : Int?
    let firstName : String?
    let lastName : String?
    let email : String?
    let username : String?
    let profilePic : String?
    let countryId : String?
    let gender : String?
    let phoneNo : String?
    let dob : String?
    let isActive : Bool?
    let created : String?
    let modified : String?
    let accessToken : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case roleId = "role_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case username = "username"
        case profilePic = "profile_pic"
        case countryId = "country_id"
        case gender = "gender"
        case phoneNo = "phone_no"
        case dob = "dob"
        case isActive = "is_active"
        case created = "created"
        case modified = "modified"
        case accessToken = "access_token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        roleId = try values.decodeIfPresent(Int.self, forKey: .roleId)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
        countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        phoneNo = try values.decodeIfPresent(String.self, forKey: .phoneNo)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
    }

}
struct UpdateCred:Codable {
    let first_name: String?
    let lastName : String?
    let email: String?
    let dob: String?
    let profile_pic : String?
    let phoneNo : String?
    
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
