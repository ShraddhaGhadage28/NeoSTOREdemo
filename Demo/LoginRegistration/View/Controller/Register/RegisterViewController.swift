//
//  RegisterViewController.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 08/08/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var FirstNameView: ViewDesign!
    @IBOutlet weak var LastNameView: ViewDesign!
    @IBOutlet weak var EmailView: ViewDesign!
    @IBOutlet weak var PasswordView: ViewDesign!
    @IBOutlet weak var ConfirmPasswordView: ViewDesign!
    
    @IBOutlet weak var phoneView: ViewDesign!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var maleButton: UIButton!
    
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var uncheckButton: UIButton!
    
    var gender: String?
    var checkFlag: Bool = false
    let selectedImage = UIImage(systemName: "circle.fill")
    let unselectedImage = UIImage(systemName: "circle")
    let checkImg = UIImage(named: "checked_icon")
    let uncheckImg = UIImage(named:"uncheck_icon")
    var viewmodel: RegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.title = ""
        navigationItem.leftBarButtonItem = backButton
        NavigationManager.shared.navigationRegiserBarUI(from: self)
        viewmodel = RegisterViewModel()
        viewmodel?.delegate = self
        FirstNameView.setUpUI()
        LastNameView.setUpUI()
        EmailView.setUpUI()
        PasswordView.setUpUI()
        ConfirmPasswordView.setUpUI()
        phoneView.setUpUI()
        placeholderColor()
        maleButton.tag = 1
        femaleButton.tag = 2
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Register"
    }
    @objc func backButtonTapped() {
        // Handle back button tap
        navigationController?.popViewController(animated: true)
    }
    func placeholderColor() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white, // Change this to your desired color
        ]
        firstName.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: attributes)
        lastName.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: attributes)
        email.attributedPlaceholder = NSAttributedString(string: "Email", attributes: attributes)
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
        confirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: attributes)
        phoneNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: attributes)
        
    }
    
    @IBAction func selectGender(_ sender: UIButton) {
        if sender.tag == 1 {
            maleButton.setImage(selectedImage, for: .normal)
            femaleButton.setImage(unselectedImage, for: .normal)
            gender = "M"
        }
        else if sender.tag == 2 {
            maleButton.setImage(unselectedImage, for: .normal)
            femaleButton.setImage(selectedImage, for: .normal)
            gender = "F"
        }
    }
    
    
    @IBAction func CheckBtnClicked(_ sender: UIButton) {
        if checkFlag == true {
            uncheckButton.setImage(uncheckImg, for: .normal)
            checkFlag = false
            
        } else{
            checkFlag = true
            uncheckButton.setImage(checkImg, for: .normal)
        }
        
    }
    
    
    @IBAction func registerBtnClicked(_ sender: UIButton) {
      
        let registerUser = User(firstName: self.firstName.text!, lastName: self.lastName.text!, email: self.email.text!, password: self.password.text!, confirmPassword: self.confirmPassword.text!, gender: self.gender,phoneNo: Int(self.phoneNumber.text ?? " "))
    
        let isValid = viewmodel?.validate(registerUser) ?? false
       
        if isValid == true
        {
            viewmodel?.checkResponse(user: registerUser, flag: checkFlag, valid: isValid)
        }
    }
    
    func successAlert(msg:String,userMsg:String,status:Int)
    {
        // Registration successful, handle the data if needed
        let alertController = UIAlertController(title: msg, message:  userMsg, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
             //Handle OK action if needed
                        if (status == 200)
                        {
                            let vc = LoginViewController.instantiate(appStoryboard: .main)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
        }

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }

    func failureAlert(msg:String) {
        let alertController = UIAlertController(title: "Registration failed", message: "\(msg)", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)

    }

}
extension RegisterViewController: DidReceivedRes {
    func didResData(msg: String, userMsg: String, status: Int) {
        successAlert(msg: msg, userMsg: userMsg, status: status)
    }
    func didAPIFailed(msg:String) {
        failureAlert(msg: msg)
    }
    
}
