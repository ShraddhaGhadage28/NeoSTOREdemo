//
//  UIImageView+Extension.swift
//  Demo
//
//  Created by Neosoft on 05/10/23.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(imgString: String){
        if let img = URL(string: imgString) {
            URLSession.shared.dataTask(with: img) { (data, response, error) in
                if let data = data,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }.resume()
        }
    }
}
