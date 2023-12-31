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
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    var viewModel: GetAccountDetailsViewModel?
    var accountInfo : UserAccountData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = GetAccountDetailsViewModel()
        viewModel?.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.title = ""
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        viewModel?.checkUserDataResponse()
    }
    @objc func backButtonTapped() {
        // Handle back button tap
        navigationController?.popViewController(animated: true)
    }
    @IBAction func editBtnClicked(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        let MyAccountViewController = storyboard.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
        navigationController?.pushViewController(MyAccountViewController, animated: true)
    }
    
    @IBAction func resetPassBtnClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        let ChangePasswordViewController = storyboard.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        navigationController?.pushViewController(ChangePasswordViewController, animated: true)
    }
}
extension EditProfileViewController : DidAccountFetched {
    func didGetAccount() {
        guard let data = viewModel?.accountDetails
        else {
            return
        }
        self.accountInfo = data
        firstName.text = data.firstName
        lastName.text = data.lastName
        email.text = data.email
        phone.text = data.phoneNo
        dob.text = data.dob
        imgView.loadImage(imgString: data.profilePic ?? "")
    }
}
