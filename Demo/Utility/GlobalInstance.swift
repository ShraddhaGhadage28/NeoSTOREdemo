//
//  GlobalInstance.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 29/08/2023.
//

import Foundation
class GlobalInstance {
    static let shared = GlobalInstance()
    private init() {}
    
    func getAccessToken() -> String {
        guard let accessToken = UserDefaults.standard.string(forKey: "AccessTokenKey") else { return "" }
        return accessToken
    }
    func setAccessToken(accessToken: String) {
        UserDefaults.standard.set(accessToken, forKey: "AccessTokenKey")
    }
}
