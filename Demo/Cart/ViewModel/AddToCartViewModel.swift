//
//  AddToCartViewModel.swift
//  Demo
//
//  Created by Shraddha Ghadage on 01/09/2023.
//

import Foundation
import Alamofire
protocol DidAddedToCart: AnyObject {
    func didGetRes(msg:String,userMsg: String,status:Int)
}
class AddToCartViewModel {
    weak var delegate: DidAddedToCart?
    func checkDataResponse(params:addToCartCred){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": "\(accessToken)"
        ]
        print(accessToken)
        utility.getPostData(url: addToCartUrl, methodType: .post
                            , requestBody: params.asDictionary, responseModel: AddToCartModel.self,headers:headers ) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.delegate?.didGetRes(msg: data.message ?? "Not Added To Cart",userMsg: data.userMsg ?? "failed",status: data.status ?? 404)
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
        
    }
}
