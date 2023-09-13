//
//  OrderListModel.swift
//  Demo
//
//  Created by Neosoft on 12/09/23.
//

import Foundation
struct OrderListModel : Codable {
    let status : Int?
    let data : [OrderListData]?
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
        data = try values.decodeIfPresent([OrderListData].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userMsg = try values.decodeIfPresent(String.self, forKey: .userMsg)
    }

}

struct OrderListData : Codable {
    let id : Int?
    let cost : Int?
    let created : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case cost = "cost"
        case created = "created"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        created = try values.decodeIfPresent(String.self, forKey: .created)
    }

}
