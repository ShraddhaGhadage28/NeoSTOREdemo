//
//  UpdateAccountViewModel.swift
//  Demo
//
//  Created by Neosoft on 08/09/23.
//

import Foundation
import Alamofire
protocol DidAccountUpdate: AnyObject {
    func didAccountUpdated(status:Int,msg:String,userMsg:String)
}
class UpdateAccountViewModel {
    weak var delegate: DidAccountUpdate?
    func checkUpdatedDataResponse(params:UpdateCred){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": "\(accessToken)"
        ]
        print(accessToken)
        utility.getPostData(url: updateAccountUrl, methodType: .post
                            , requestBody: params.asDictionary, responseModel: UpdateAccountModel.self,headers:headers ) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.delegate?.didAccountUpdated(status: data.status ?? 404, msg: data.message ?? "", userMsg: data.userMsg ?? "")
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
    }
}
