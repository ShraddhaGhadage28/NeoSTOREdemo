//
//  ChangePasswordViewController.swift
//  Demo
//
//  Created by Neosoft on 13/09/23.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var currentPassword: UITextField!
    
    @IBOutlet weak var view1: ViewDesign!
    
    @IBOutlet weak var view2: ViewDesign!
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var view3: ViewDesign!
    @IBOutlet weak var confirmPassword: UITextField!
    var viewModel: ChangePasswordViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.title = ""
        navigationItem.leftBarButtonItem = backButton
        NavigationManager.shared.createNavigationBar(from: self, forType: .address)
        navigationItem.title = "Reset Password"
        view1.setUpUI()
        view2.setUpUI()
        view3.setUpUI()
        placeholderColor()
        viewModel = ChangePasswordViewModel()
        viewModel?.delegate = self
    }
    @objc func backButtonTapped() {
        // Handle back button tap
        navigationController?.popViewController(animated: true)
    }
    func placeholderColor() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white, // Change this to your desired color
        ]
        currentPassword.attributedPlaceholder = NSAttributedString(string: "Current Password", attributes: attributes)
        newPassword.attributedPlaceholder = NSAttributedString(string: "New Password", attributes: attributes)
        confirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: attributes)
    }

    @IBAction func resetClicked(_ sender: UIButton) {
        let params:[String:String] = ["old_password":currentPassword.text!,
                      "password":newPassword.text!,
                      "confirm_password":confirmPassword.text!]
        viewModel?.checkUserDataResponse(params: params)
    }
}
extension ChangePasswordViewController: DidSetPassword {
    func didSetPass(status: Int, msg: String, userMsg: String) {
        let alertController = UIAlertController(title: "\(msg)", message: "\(userMsg)", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if (status == 200)
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil) // Use the appropriate storyboard name
                if let LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    self.navigationController?.pushViewController(LoginViewController, animated: true)
                    
                }
            }
        }
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
}
