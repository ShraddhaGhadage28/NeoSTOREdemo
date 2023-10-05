//
//  ForgotPasswordViewModel.swift
//  Demo
//
//  Created by Neosoft on 13/09/23.
//

import Foundation
protocol DidGetPassword: AnyObject {
    func didGetPass(status:Int,msg:String,userMsg:String)
}
class ForgotPasswordViewModel {
    var delegate : DidGetPassword?
    
    func checkPassDataResponse(params:[String:String]){
        let utility = Utility()
        utility.getPostData(url: forgotPasswordUrl, methodType: .post
                            , requestBody:params , responseModel: ChangePasswordModel.self ) { result in
            switch result {
            case .success(let data):
                guard let data = data else{
                    return
                }
                print("Success:", data)
                self.delegate?.didGetPass(status: data.status ?? 0, msg: data.message ?? "", userMsg: data.userMsg ?? "")
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
    }
}
