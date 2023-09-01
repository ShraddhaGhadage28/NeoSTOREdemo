//
//  MyCartTableViewCell.swift
//  Demo
//
//  Created by Shraddha Ghadage on 01/09/2023.
//

import UIKit

class MyCartTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
