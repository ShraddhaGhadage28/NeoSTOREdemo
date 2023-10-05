//
//  LoginViewModel.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 17/08/2023.
//

import Foundation
import Alamofire

protocol DidLoginRes: AnyObject {
    func didResData(valid: Bool)
}
class LoginViewModel {
    weak var delegate: DidLoginRes?
    func checkResponse(user: LoginCred) {
        let utility = Utility.shared
        
        utility.getPostData(url: loginUrl,
                            methodType: .post
                            ,requestBody: user.asDictionary,
                            responseModel: LoginResponse.self) { result in
            switch result {
            case .success(let data):
                print("Login successful:", data ?? "")
                let accessToken = data?.data?.accessToken
                GlobalInstance.shared.setAccessToken(accessToken: accessToken ?? "")
                self.delegate?.didResData(valid: data?.status == 200)
            case .failure(let error):
                print("Login failed:", error)
                
            }
        }
    }
}
