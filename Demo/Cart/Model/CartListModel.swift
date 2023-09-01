//
//  CartListModel.swift
//  Demo
//
//  Created by Shraddha Ghadage on 01/09/2023.
//

import Foundation
struct CartListResponse : Codable {
    let status : Int?
    let data : [CartListData]?
    let count : Int?
    let total : Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case count = "count"
        case total = "total"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent([CartListData].self, forKey: .data)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }
}

struct CartListData : Codable {
    let id : Int?
    let productId : Int?
    let quantity : Int?
    let product : CartProduct?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case productId = "product_id"
        case quantity = "quantity"
        case product = "product"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        productId = try values.decodeIfPresent(Int.self, forKey: .productId)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        product = try values.decodeIfPresent(CartProduct.self, forKey: .product)
    }

}

struct CartProduct : Codable {
    let id : Int?
    let name : String?
    let cost : Int?
    let productCategory : String?
    let productImages : String?
    let subTotal : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case cost = "cost"
        case productCategory = "product_category"
        case productImages = "product_images"
        case subTotal = "sub_total"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        productCategory = try values.decodeIfPresent(String.self, forKey: .productCategory)
        productImages = try values.decodeIfPresent(String.self, forKey: .productImages)
        subTotal = try values.decodeIfPresent(Int.self, forKey: .subTotal)
    }

}
