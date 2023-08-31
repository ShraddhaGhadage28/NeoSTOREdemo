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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewmodel = LoginViewModel()
        viewmodel?.delegate = self
        userView.setUpUI()
        passwordView.setUpUI()
        placeholderColor()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        forgotPassword.addGestureRecognizer(tapGesture)
        forgotPassword.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.isHidden = true
    }
    //Mark:- placeholder color setting
    func placeholderColor() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white, // Change this to your desired color
        ]
        loginUserName.attributedPlaceholder = NSAttributedString(string: "Username", attributes: attributes)
        loginPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        // Perform your action here
        // Instantiate and present the ForgotPasswordViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Use the appropriate storyboard name
        if let forgotPasswordViewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController {
            self.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
        }
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
         let loginCredentials = LoginCred(email: "shamal12451@gmail.com", password: "123456")
//        let loginCredentials = LoginCred(email: loginUserName.text!, password: loginPassword.text!)
        
        viewmodel?.checkResponse(user: loginCredentials)
    }
    
    @IBAction func plusBtnClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Use the appropriate storyboard name
        if let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            self.navigationController?.pushViewController(registerViewController, animated: true)
        }
        
       
        
    }
    func failureAlert() {
        let alertController = UIAlertController(title: "Login failed", message: "failed", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Handle OK action if needed
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}
extension LoginViewController: DidLoginRes {
    func didResData(status: Int) {
        if (status == 200)
        {
            let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
                   
                   if let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as? HomeViewController {
                       // Perform navigation
                       self.navigationController?.pushViewController(homeViewController, animated: true)
                   }
        }
        
    }
    func didAPIFailed() {
        failureAlert()
    }
    
}


