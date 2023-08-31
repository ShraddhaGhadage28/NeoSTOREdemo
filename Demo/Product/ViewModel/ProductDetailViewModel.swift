//
//  ProductDetailViewModel.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 24/08/2023.
//

import Foundation

class ProductDetailViewModel {
    weak var delegate : DataPassing?
    var dataInDetail: ProductDetailsData?
   
    func checkGetData(id:Int)
    {
        let utility = Utility()
        let url = getProductDetailUrl+"\(id)"
        utility.getPostData(url: url, methodType: .get
                            , requestBody: [:], responseModel: ProductDetailModel.self) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.dataInDetail = data.data
                self.delegate?.dataPass()
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
        
    }
}

