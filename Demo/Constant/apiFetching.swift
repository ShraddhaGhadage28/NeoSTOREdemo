//
//  apiFetching.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 17/08/2023.
//

import Foundation
import Alamofire

struct Utility {
    static var shared = Utility()
    
    func getPostData<T:Codable>(url : String,isSnakecase: Bool? = false, methodType: HTTPMethod, requestBody: Dictionary<String,Any>,responseModel:T.Type, headers: HTTPHeaders?=nil, completion: @escaping (Result<T?, Error>) -> Void) {
        
        AF.request(url, method: methodType, parameters: requestBody, encoding: URLEncoding.default, headers: headers)
            .response { response in
                switch response.result {
                case .success(let data):
                    
                    if let data = data {
                        if let responseString = String(data: data, encoding: .utf8) {
                            print("Response data:", responseString)
                            
                        } else {
                            print("Response data is not a valid UTF-8 string")
                        }
                        let decoder = JSONDecoder()
                        
                        let value = try? decoder.decode(responseModel.self, from: data)
                        completion(.success(value))
                        
                    } else {
                        print("No response data")
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
