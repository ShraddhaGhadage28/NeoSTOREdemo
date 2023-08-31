//
//  CartManager.swift
//  Demo
//
//  Created by Shraddha Ghadage on 31/08/2023.
//

import Foundation
//singleton Class
class CartManager {
    static let shared = CartManager()
    private init() {}
    
    var cartItemCount: Int = 0
}
