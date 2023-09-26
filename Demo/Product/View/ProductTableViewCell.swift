//
//  ProductTableViewCell.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 22/08/2023.
//

import UIKit
import Cosmos

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var producer: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var stars: CosmosView!
    
    weak var delegate: TableViewCellDelegate?
    
    
    func configureWithRating(_ rating: Int) {
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        price.adjustsFontSizeToFitWidth = true
        price.minimumScaleFactor = 0.5
        stars.settings.updateOnTouch = false
        stars.settings.starSize = 18
        stars.settings.emptyBorderColor = UIColor.lightGray
        stars.settings.emptyColor = UIColor.lightGray
        stars.rating = Double(rating)

        }
}
