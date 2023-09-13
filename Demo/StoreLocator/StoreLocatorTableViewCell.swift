//
//  StoreLocatorTableViewCell.swift
//  Demo
//
//  Created by Neosoft on 13/09/23.
//

import UIKit

class StoreLocatorTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subname: UILabel!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
