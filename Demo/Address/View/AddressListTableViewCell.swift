//
//  AddressListTableViewCell.swift
//  Demo
//
//  Created by Shraddha Ghadage on 02/09/2023.
//

import UIKit
import CoreData

class AddressListTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var clearBtn: UIButton!
    
    var onClickClearBtn: (() -> ())?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup(useNname: String?, userAddress: String?){
        name.text = useNname
        address.text = userAddress
    }
    
   
    func selectBtnClicked(selected:Bool) {
        if selected {
            selectBtn.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        } else {
            selectBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    @IBAction func clearBtnTapped(_ sender: UIButton){
        onClickClearBtn?()
    }
    
    @IBAction func selelctImgClick(_ sender: UIButton) {
        // Determine the indexPath of the cell
               if let tableView = self.superview as? UITableView, let indexPath = tableView.indexPath(for: self) {
                   // Select the cell
                   tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                   selectBtnClicked(selected:true)
                   // Deselect other cells if needed
                   for otherIndexPath in tableView.indexPathsForSelectedRows ?? [] {
                       if otherIndexPath != indexPath {
                           tableView.deselectRow(at: otherIndexPath, animated: true)
                       }
                   }
               }
    }
    
}
