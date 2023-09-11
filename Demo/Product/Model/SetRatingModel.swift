//
//  SetRatingModel.swift
//  Demo
//
//  Created by Neosoft on 07/09/23.
//

import Foundation
struct setRatingResponse : Codable {
    let status : Int?
    let data : RatingData?
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
        data = try values.decodeIfPresent(RatingData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userMsg = try values.decodeIfPresent(String.self, forKey: .userMsg)
    }

}

struct RatingData : Codable {
    let id : Int?
    let productCategoryId : Int?
    let name : String?
    let producer : String?
    let description : String?
    let cost : Int?
    let rating : Double?
    let viewCount : Int?
    let created : String?
    let modified : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case productCategoryId = "product_category_id"
        case name = "name"
        case producer = "producer"
        case description = "description"
        case cost = "cost"
        case rating = "rating"
        case viewCount = "view_count"
        case created = "created"
        case modified = "modified"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        productCategoryId = try values.decodeIfPresent(Int.self, forKey: .productCategoryId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        producer = try values.decodeIfPresent(String.self, forKey: .producer)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        viewCount = try values.decodeIfPresent(Int.self, forKey: .viewCount)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
    }

}
