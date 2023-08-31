//
//  File.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 11/08/2023.
//

import Foundation

let baseUrl = "http://staging.php-dev.in:8844/trainingapp/api/"
let registerUrl = "\(baseUrl)users/register"
let loginUrl = "\(baseUrl)users/login"
let getProductUrl = "\(baseUrl)products/getList?product_category_id="
let getProductDetailUrl = "\(baseUrl)products/getDetail?product_id="

    
let setRatingUrl = "\(baseUrl)products/setRating"
let fetchProfileUrl = "\(baseUrl)users/getUserData"
