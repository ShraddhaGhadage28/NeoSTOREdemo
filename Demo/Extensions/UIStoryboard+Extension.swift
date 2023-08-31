//
//  UIStoryboard+Extension.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 28/08/2023.
//

import Foundation
import UIKit

extension UIStoryboard {
    static func getStoryboardController(name: String, controllerName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name,
                                      bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: controllerName)
     }
}
