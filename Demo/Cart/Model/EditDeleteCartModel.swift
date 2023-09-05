//
//  EditCartModel.swift
//  Demo
//
//  Created by Shraddha Ghadage on 05/09/2023.
//

import Foundation
struct EditDeleteCartModel : Codable {
    let status : Int?
    let data : Bool?
    let totalCarts : Int?
    let message : String?
    let userMsg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case totalCarts = "total_carts"
        case message = "message"
        case userMsg = "user_msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(Bool.self, forKey: .data)
        totalCarts = try values.decodeIfPresent(Int.self, forKey: .totalCarts)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userMsg = try values.decodeIfPresent(String.self, forKey: .userMsg)
    }

}
