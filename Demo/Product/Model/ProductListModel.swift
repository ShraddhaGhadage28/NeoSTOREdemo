//
//  Product.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 21/08/2023.
//

import Foundation
import UIKit


struct ProductListModel:Codable {
    let status : Int?
    let data : [ProductData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent([ProductData].self, forKey: .data)
    }
   

}

struct ProductData:Codable{
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
    let productImages : String?

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
        productImages = try values.decodeIfPresent(String.self, forKey: .productImages)
    }

}

struct productList {
    var productList: [productContent] = []
    init () {
        setProduct()
    }
    mutating func setProduct() {
        
        let contentTables = productContent(image: UIImage(named: "tableicon"),
                                           contentId: 1)
        productList.append(contentTables)
        
        let contentChairs = productContent(image: UIImage(named: "chairsicon"),
                                           contentId: 2)
        productList.append(contentChairs)
        
        let contentSofas = productContent(image: UIImage(named: "sofaicon"),
                                          contentId: 3)
        productList.append(contentSofas)
        
        let contentCupboards = productContent(image: UIImage(named: "cupboardicon"),
                                              contentId: 4)
        productList.append(contentCupboards)
        
    }
}

struct productContent {
    var image: UIImage?
    var contentId: Int?
}

 
