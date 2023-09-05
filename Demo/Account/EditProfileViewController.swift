//
//  EditProfileViewController.swift
//  Demo
//
//  Created by Shraddha Ghadage on 05/09/2023.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameView: ViewDesign!
    @IBOutlet weak var lastNameView: ViewDesign!
    @IBOutlet weak var emailView: ViewDesign!
    @IBOutlet weak var phoneView: ViewDesign!
    
    @IBOutlet weak var dobView: ViewDesign!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameView.setUpUI()
        lastNameView.setUpUI()
        emailView.setUpUI()
        phoneView.setUpUI()
        dobView.setUpUI()
    }
    
    @IBAction func submitBtnClicked(_ sender: UIButton) {
    }
    
}
