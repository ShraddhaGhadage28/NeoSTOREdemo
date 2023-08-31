//
//  RegisterViewModel.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 11/08/2023.
//

import Foundation
import Alamofire

protocol DidReceivedRes: AnyObject {
    func didResData(msg: String, userMsg: String, status: Int)
    func didAPIFailed(msg: String)
}
class RegisterViewModel {
    
   weak var delegate: DidReceivedRes?
    func validate(_ parameters: User) -> Bool {
        guard let firstname = parameters.firstName, !firstname.isEmpty else {
            self.delegate?.didAPIFailed(msg:"First Name is empty")
            return false
        }
        
        guard let lastName = parameters.lastName, !lastName.isEmpty else {
            self.delegate?.didAPIFailed(msg:"Last Name is empty")
            return false
        }
        
        guard let email = parameters.email, !email.isEmpty, isValidEmail(email) else {
            self.delegate?.didAPIFailed(msg:"Fill Email correctly")
            return false
        }
        
        guard let password = parameters.password, !password.isEmpty, password.count >= 6 else {
            self.delegate?.didAPIFailed(msg:"password should be minimum 6 digits")
            return false
        }
        guard let gender = parameters.gender, gender != nil else
        {
            self.delegate?.didAPIFailed(msg:"Gender is not selected")
            return false
        }
        guard let confirmPassword = parameters.confirmPassword, !confirmPassword.isEmpty, confirmPassword == password else {
            if parameters.confirmPassword == ""
            {
                self.delegate?.didAPIFailed(msg: "Confirm Password is empty")
            } else if parameters.confirmPassword != parameters.password {
                self.delegate?.didAPIFailed(msg:"password is not matching")
            }
            return false
        }
        
        
        
        if let phoneNo = parameters.phoneNo {
            let phoneNumberString = String(phoneNo)
            if phoneNumberString.count != 10 {
                return false // Phone number should have exactly 10 digits
            }
            
            let validPrefixes = ["7", "8", "9"] // Valid prefixes for Indian mobile numbers
            let firstDigit = String(phoneNumberString.first ?? " ")
            if !validPrefixes.contains(firstDigit) {
                return false // Phone number should start with a valid prefix
            }
        }
        return true
    }
    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".com")
    }
    
    func checkResponse(user: User,flag: Bool, valid: Bool) {
        let utility = Utility()
        if valid && flag == true
        {
            utility.getPostData(url: registerUrl, methodType: .post ,requestBody: user.asDictionary,responseModel: RegisterResponse.self) { result in
                switch result {
                case .success(let data):
                    let msg = data?.message
                    let userMsg = data?.userMsg
                    let status = data?.status
                    print("Registration successful:", data)
                    
                    self.delegate?.didResData(msg: msg ?? "", userMsg: userMsg ?? "", status: status!)
                    
                case .failure(let error):
                    print("Registration failed:", error)
                }
            }
        } else {
             self.delegate?.didAPIFailed(msg:"check terms and conditions")
            print("Invalid registration parameters.")
        }
    }
}
