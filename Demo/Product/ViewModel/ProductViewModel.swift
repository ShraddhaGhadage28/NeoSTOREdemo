//
//  ProductViewModel.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 21/08/2023.
//

import Foundation
protocol DataPassing : AnyObject {
    func dataPass()
}
protocol TableViewCellDelegate: AnyObject {
    func didTapCell(with data: String)
}
class ProductViewModel {
    weak var delegate : DataPassing?
    var dataArr: [ProductData]?
   
    func checkGetData(id:Int)
    {
        let utility = Utility()
        let url = getProductUrl+"\(id)"
        utility.getPostData(url: url, methodType: .get
                            , requestBody: [:], responseModel: ProductListModel.self) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.dataArr = data.data
                self.delegate?.dataPass()
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
        
    }
    func getProductData(index:Int) -> ProductData? {
        return self.dataArr?[index]
    }
}

