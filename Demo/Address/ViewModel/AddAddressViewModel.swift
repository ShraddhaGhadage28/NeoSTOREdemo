//
//  AddAddressViewModel.swift
//  Demo
//
//  Created by Neosoft on 06/09/23.
//

import Foundation
protocol DidAddressCorrect:AnyObject {
    func didAddressGet(msg:String)
}
class AddAddressViewModel {
    weak var delegate: DidAddressCorrect?
    func validate(_ parameters: Address) -> Bool {
        guard let address = parameters.address, !address.isEmpty else {
            self.delegate?.didAddressGet(msg:"Address is empty")
            return false
        }
        guard let landmark = parameters.landmark, !landmark.isEmpty else {
            self.delegate?.didAddressGet(msg:"landmark is empty")
            return false
        }
        guard let city = parameters.city, !city.isEmpty else {
            self.delegate?.didAddressGet(msg:"City is empty")
            return false
        }
        guard let state = parameters.state, !state.isEmpty else {
            self.delegate?.didAddressGet(msg:"State is empty")
            return false
        }
        guard let country = parameters.country, !country.isEmpty else {
            self.delegate?.didAddressGet(msg:"Country is empty")
            return false
        }
        guard let zipcode = parameters.zipcode, !zipcode.isEmpty else {
            self.delegate?.didAddressGet(msg:"Zipcode is empty")
            return false
        }
        return true
    }
}
