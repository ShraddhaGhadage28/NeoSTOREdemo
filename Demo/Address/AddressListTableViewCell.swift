//
//  AddressListTableViewCell.swift
//  Demo
//
//  Created by Shraddha Ghadage on 02/09/2023.
//

import UIKit

class AddressListTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(useNname: String?, userAddress: String?){
        name.text = useNname
        address.text = userAddress
    }
    
    @IBAction func clearBtnClicked(_ sender: UIButton) {
        
    }
    
}
