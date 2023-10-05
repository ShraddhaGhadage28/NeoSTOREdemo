//
//  ViewDesign.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 09/08/2023.
//

import UIKit

class ViewDesign: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    func setUpUI() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        
    }
}
