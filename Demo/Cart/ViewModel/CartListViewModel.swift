//
//  CartListViewModel.swift
//  Demo
//
//  Created by Shraddha Ghadage on 01/09/2023.
//

import Foundation
import Alamofire
protocol DidCartListArrived: AnyObject {
    func didCartUpdated()
    func didCartEmpty()
}
class CartListViewModel {
    weak var delegate: DidCartListArrived?
    var cartDataArr : [CartListData]?
    var status:Int?
    var total : Int?
    func checkCartList(){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": "\(accessToken)"
        ]
        print(accessToken)
        utility.getPostData(url: cartListUrl, methodType: .get
                            , requestBody: [:], responseModel: CartListResponse.self, headers:headers ) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
//                guard let data = data else{
//                    return
//                }
                if data?.data == nil {
                    self.delegate?.didCartEmpty()
                } else {
                    self.cartDataArr = data?.data
                    self.total = data?.total ?? 0
                    self.delegate?.didCartUpdated()
                }
                
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
        
    }
}
