//
//  MyAccountViewController.swift
//  Demo
//
//  Created by Shraddha Ghadage on 05/09/2023.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    @IBOutlet weak var nameView: ViewDesign!
    @IBOutlet weak var lastNameView: ViewDesign!
    @IBOutlet weak var emailView: ViewDesign!
    @IBOutlet weak var phoneView: ViewDesign!
    @IBOutlet weak var dobView: ViewDesign!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.navigationRegiserBarUI(from: self)
        nameView.setUpUI()
        lastNameView.setUpUI()
        emailView.setUpUI()
        phoneView.setUpUI()
        dobView.setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "My Account"
    }
    
    @IBAction func editBtnClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        let editProfileViewController = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    
    @IBAction func resetPassBtnClicked(_ sender: UIButton) {
    }
}
