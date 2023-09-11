//
//  GetAccountDetailsViewModel.swift
//  Demo
//
//  Created by Neosoft on 07/09/23.
//

import Foundation
import Alamofire
protocol DidAccountFetched: AnyObject {
    func didGetAccount()
}
class GetAccountDetailsViewModel {
    var delegate : DidAccountFetched?
    var accountDetails : UserAccountData?
    
    func checkUserDataResponse(){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": "\(accessToken)"
        ]
        print(accessToken)
        utility.getPostData(url: getAccountUrl, methodType: .get
                            , requestBody: [:], responseModel: GetAccountDetailsModel.self,headers:headers ) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.accountDetails = data.data?.userData
                self.delegate?.didGetAccount()
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
    }
}
