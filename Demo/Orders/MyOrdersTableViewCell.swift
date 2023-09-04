//
//  MyOrdersTableViewCell.swift
//  Demo
//
//  Created by Shraddha Ghadage on 04/09/2023.
//

import UIKit

class MyOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var orderedDate: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
