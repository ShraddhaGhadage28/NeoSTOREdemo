//
//  PlaceOrderViewModel.swift
//  Demo
//
//  Created by Neosoft on 12/09/23.
//

import Foundation
import Alamofire
protocol DidOrderFetched: AnyObject {
    func didGetOrder(status:Int,msg:String,userMsg:String)
}
class PlaceOrderViewModel {
    var delegate : DidOrderFetched?
    
    func checkUserDataResponse(address:String){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": "\(accessToken)"
        ]
        print(accessToken)
        utility.getPostData(url: fetchOrderUrl, methodType: .post
                            , requestBody: ["address":address], responseModel: PlaceOrderModel.self,headers:headers ) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.delegate?.didGetOrder(status: data.status ?? 404, msg: data.message ?? "", userMsg: data.userMsg ?? "")
            case .failure(let error):
                print("Failed:", error)
            }
        }
    }
}
