//
//  Model.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 29/08/2023.
//


import Foundation


// MARK: - Welcome
struct SideMenu: Codable {
    var status: Int
    var data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    var userData: UserDataNew
    var productCategories: [ProductCategory]
    var totalCarts, totalOrders: Int

    enum CodingKeys: String, CodingKey {
        case userData = "user_data"
        case productCategories = "product_categories"
        case totalCarts = "total_carts"
        case totalOrders = "total_orders"
    }
}

// MARK: - ProductCategory
struct ProductCategory: Codable {
    var id: Int
    var name: String
    var iconImage: String
    var created, modified: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case iconImage = "icon_image"
        case created, modified
    }
}

// MARK: - UserData
struct UserDataNew: Codable {
    var id, roleID: Int
    var firstName, lastName, email, username: String
    var profilePic, countryID: String?
    var gender, phoneNo: String
    var dob: String?
    var isActive: Bool
    var created, modified: String
    var accessToken: String

    enum CodingKeys: String, CodingKey {
        case id
        case roleID = "role_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, username
        case profilePic = "profile_pic"
        case countryID = "country_id"
        case gender
        case phoneNo = "phone_no"
        case dob
        case isActive = "is_active"
        case created, modified
        case accessToken = "access_token"
    }
}


