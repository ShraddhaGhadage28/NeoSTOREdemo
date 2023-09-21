//
//  MyCartTableViewCell.swift
//  Demo
//
//  Created by Shraddha Ghadage on 01/09/2023.
//

import UIKit
import iOSDropDown

class MyCartTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!

 @IBOutlet weak var dropDown: DropDown!
    
    @IBOutlet weak var price: UILabel!
    var index: Int = 0
    var onDropdownSelection: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dropDown.endEditing(true)
        dropDownSetup()
        dropDown.optionArray = ["1","2","3","4","5","6","7","8"]
        dropDown.showList()
        dropDown.didSelect { [weak self] (selectedItem, _, _) in
        self?.onDropdownSelection?(selectedItem)
        }
    }
                
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func dropDownSetup() {
                let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 15, height: 10))
                imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .black
                let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        //containerView.backgroundColor = .red
                containerView.addSubview(imageView)

                // Set the right view of the text field
                dropDown.rightView = containerView
                dropDown.rightViewMode = .always // To always show the right view
            }
    
}

