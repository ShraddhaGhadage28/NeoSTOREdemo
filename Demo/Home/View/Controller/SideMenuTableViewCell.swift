//
//  SideMenuTableViewCell.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 29/08/2023.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var addToCartLabel: UILabel!
    
    @IBOutlet weak var badgeView: UIView!
    
    var updatedCart: String = "" {
            didSet {
                addToCartLabel.text = updatedCart
            }
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
