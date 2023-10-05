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
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    var getAccountDetailsViewModel:GetAccountDetailsViewModel?
    var updateAccountViewModel: UpdateAccountViewModel?
    var accountInfo : UserAccountData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.createNavigationBar(from: self, forType: .back)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imgView.addGestureRecognizer(tapGesture)
        imgView.isUserInteractionEnabled = true
        
        setupViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationManager.shared.isbackTapped = { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        }
        self.navigationItem.title = "My Account"
    }
   
    @objc func imageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary 
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func submitBtnClicked(_ sender: UIButton) {
        guard let imageData = imgView.image?.jpegData(compressionQuality: 0.2) else { return }
        print(imageData)
        let baseString = "data:image/jpg;base64,"+imageData.base64EncodedString()
        print(baseString)
      //  let imageString = String(data: imageData, encoding: .utf8)
        let newCred = UpdateCred(first_name: firstName.text, lastName: lastName.text, email: email.text, dob: dob.text, profile_pic: baseString , phoneNo: phone.text)
        updateAccountViewModel?.checkUpdatedDataResponse(params: newCred)
    }
    
    private func setupViewModel() {
        getAccountDetailsViewModel = GetAccountDetailsViewModel()
        getAccountDetailsViewModel?.delegate = self
        getAccountDetailsViewModel?.checkUserDataResponse()
        
        updateAccountViewModel = UpdateAccountViewModel()
        updateAccountViewModel?.delegate = self
    }
}
extension MyAccountViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
extension MyAccountViewController: DidAccountUpdate {
    func didAccountUpdated(status: Int, msg: String, userMsg: String) {
        let alertController = UIAlertController(title: msg,
                                                message: userMsg,
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if (status == 200)
            {
                self.navigationController?.popViewController(animated: true)

            }
        }

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
}
extension MyAccountViewController : DidAccountFetched {
    func didGetAccount() {
        guard let data = getAccountDetailsViewModel?.accountDetails
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

