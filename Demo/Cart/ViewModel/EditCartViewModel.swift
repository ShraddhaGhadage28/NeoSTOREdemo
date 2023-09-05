//
//  EditCartViewModel.swift
//  Demo
//
//  Created by Shraddha Ghadage on 05/09/2023.
//

import Foundation
import Alamofire

class EditCartViewModel {
    func checkEditedDataResponse(params:editToCartCred){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": "\(accessToken)"
        ]
        print(accessToken)
        utility.getPostData(url: editCartUrl, methodType: .post
                            , requestBody: params.asDictionary, responseModel: EditDeleteCartModel.self,headers:headers ) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
    }
}
struct editToCartCred:Codable {
    let productId: Int?
    let quantity: String?
    
    var asDictionary: [String: Any] {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
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
