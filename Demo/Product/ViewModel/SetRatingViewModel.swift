//
//  SetRatingViewModel.swift
//  Demo
//
//  Created by Neosoft on 07/09/23.
//

import Foundation
protocol RatingRes: AnyObject {
    func didRatingSet(msg:String,userMsg:String)
}
class SetRatingViewModel {
    var delegate:RatingRes?
    func checkRatingData(productId:Int,rating:Int)
    {
        let utility = Utility()
        utility.getPostData(url: setRatingUrl, methodType: .post
                            , requestBody: ["product_id":productId,"rating":rating], responseModel: setRatingResponse.self) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.delegate?.didRatingSet(msg: data.message ?? "", userMsg: data.userMsg ?? "")
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
        
    }
}

