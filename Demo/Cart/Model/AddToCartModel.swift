//
//  AddToCartModel.swift
//  Demo
//
//  Created by Shraddha Ghadage on 01/09/2023.
//

import Foundation
struct AddToCartModel : Codable {
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
struct addToCartCred:Codable {
    let productId: Int?
    let quantity: String?
    
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
