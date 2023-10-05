//
//  ForgotPasswordViewController.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 09/08/2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailView: ViewDesign!
    @IBOutlet weak var email: UITextField!
    var viewModel : ForgotPasswordViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailView.setUpUI()
        placeholderColor()
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.title = ""
        navigationItem.leftBarButtonItem = backButton
        NavigationManager.shared.createNavigationBar(from: self, forType: .back)
        navigationItem.title = "Forgot Password"
        viewModel = ForgotPasswordViewModel()
        viewModel?.delegate = self
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func placeholderColor() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white, // Change this to your desired color
        ]
        let emailPlaceholder = NSAttributedString(string: "E-mail", attributes: attributes)
        email.attributedPlaceholder = emailPlaceholder
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        let para: [String:String] = ["email": email.text ?? ""]
        viewModel?.checkPassDataResponse(params: para)
    }
}
extension ForgotPasswordViewController: DidGetPassword {
    func didGetPass(status: Int, msg: String, userMsg: String) {
        let alertController = UIAlertController(title: "\(msg)", message: "\(userMsg)", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if (status == 200)
            {
                let vc = LoginViewController.instantiate(appStoryboard: .main)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
}
