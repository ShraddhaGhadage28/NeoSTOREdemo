//
//  Product.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 24/08/2023.
//

import Foundation

struct ProductDetailModel : Codable {
    let status : Int?
    let data : ProductDetailsData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(ProductDetailsData.self, forKey: .data)
    }

}


struct ProductDetailsData : Codable {
    let id : Int?
    let productCategoryId : Int?
    let name : String?
    let producer : String?
    let description : String?
    let cost : Int?
    let rating : Int?
    let view_count : Int?
    let created : String?
    let modified : String?
    let productImages : [ProductImages]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case productCategoryId = "product_category_id"
        case name = "name"
        case producer = "producer"
        case description = "description"
        case cost = "cost"
        case rating = "rating"
        case view_count = "view_count"
        case created = "created"
        case modified = "modified"
        case productImages = "product_images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        productCategoryId = try values.decodeIfPresent(Int.self, forKey: .productCategoryId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        producer = try values.decodeIfPresent(String.self, forKey: .producer)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
        view_count = try values.decodeIfPresent(Int.self, forKey: .view_count)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        productImages = try values.decodeIfPresent([ProductImages].self, forKey: .productImages)
    }

}
struct ProductImages : Codable {
    let id : Int?
    let productId : Int?
    let image : String?
    let created : String?
    let modified : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case productId = "product_id"
        case image = "image"
        case created = "created"
        case modified = "modified"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        productId = try values.decodeIfPresent(Int.self, forKey: .productId)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
    }

}
