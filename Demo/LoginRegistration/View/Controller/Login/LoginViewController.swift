//
//  ViewController.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 07/08/2023.
//

import UIKit
//import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginUserName: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var passwordView: ViewDesign!
    @IBOutlet weak var userView: ViewDesign!
    @IBOutlet weak var forgotPassword: UILabel!
    var viewmodel: LoginViewModel?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
        backButton.title = ""
        navigationItem.leftBarButtonItem = backButton
        viewmodel = LoginViewModel()
        viewmodel?.delegate = self
        placeholderColor()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        forgotPassword.addGestureRecognizer(tapGesture)
        forgotPassword.isUserInteractionEnabled = true
    }
    
    //MARK :- placeholder color setting
    func placeholderColor() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white, // Change this to your desired color
        ]
        loginUserName.attributedPlaceholder = NSAttributedString(string: "Username", attributes: attributes)
        loginPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        let vc = ForgotPasswordViewController.instantiate(appStoryboard: .main)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        let loginCredentials = LoginCred(email: "shital@gmail.com", password: "123456")
        //let loginCredentials = LoginCred(email: loginUserName.text!, password: loginPassword.text!)
        
        viewmodel?.checkResponse(user: loginCredentials)
    }
    
    @IBAction func plusBtnClicked(_ sender: UIButton) {
        let vc = RegisterViewController.instantiate(appStoryboard: .main)
        navigationController?.pushViewController(vc, animated: true)
    }
    func failureAlert() {
        let alertController = UIAlertController(title: "User login unsuccessful.",
                                                message: "Email or password is wrong. try again",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true)
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}
extension LoginViewController: DidLoginRes {
    func didResData(valid: Bool) {
        if valid
        {
            let vc = HomeViewController.instantiate(appStoryboard: .home)
            navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            failureAlert()
        }
    }
    
}


