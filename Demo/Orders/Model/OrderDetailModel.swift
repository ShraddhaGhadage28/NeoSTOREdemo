//
//  OrderDetailModel.swift
//  Demo
//
//  Created by Neosoft on 12/09/23.
//

import Foundation
struct OrderDetailModel : Codable {
    let status : Int?
    let data : OrderDetailData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(OrderDetailData.self, forKey: .data)
    }

}
struct OrderDetailData : Codable {
    let id : Int?
    let cost : Int?
    let address : String?
    let orderDetails : [OrderDetails]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case cost = "cost"
        case address = "address"
        case orderDetails = "order_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        orderDetails = try values.decodeIfPresent([OrderDetails].self, forKey: .orderDetails)
    }

}
struct OrderDetails : Codable {
    let id : Int?
    let orderId : Int?
    let productId : Int?
    let quantity : Int?
    let total : Int?
    let prodName : String?
    let prodCatName : String?
    let prodImage : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case orderId = "order_id"
        case productId = "product_id"
        case quantity = "quantity"
        case total = "total"
        case prodName = "prod_name"
        case prodCatName = "prod_cat_name"
        case prodImage = "prod_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        orderId = try values.decodeIfPresent(Int.self, forKey: .orderId)
        productId = try values.decodeIfPresent(Int.self, forKey: .productId)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        prodName = try values.decodeIfPresent(String.self, forKey: .prodName)
        prodCatName = try values.decodeIfPresent(String.self, forKey: .prodCatName)
        prodImage = try values.decodeIfPresent(String.self, forKey: .prodImage)
    }

}
