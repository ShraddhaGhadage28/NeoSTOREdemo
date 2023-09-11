//
//  AddAddressViewController.swift
//  Demo
//
//  Created by Shraddha Ghadage on 02/09/2023.
//

import UIKit
import CoreData

class AddAddressViewController: UIViewController {

    @IBOutlet weak var address: UITextView!
    
    @IBOutlet weak var cityMain: UITextField!
    
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var zipcode: UITextField!
    
    
    @IBOutlet weak var state: UITextField!
    
    @IBOutlet weak var country: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var viewModel: AddAddressViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.navigationCustomBarUI(from: self)
        navigationItem.title = "Add Address"
        viewModel = AddAddressViewModel()
        viewModel?.delegate = self
    }
    

    @IBAction func saveBtnClicked(_ sender: UIButton) {
    
        let addressEntity = NSEntityDescription.entity(forEntityName: "AddressEntity",in: context)!
        let newAddress = NSManagedObject(entity: addressEntity, insertInto: context)
        newAddress.setValue(address.text, forKey: "address")
        newAddress.setValue(cityMain.text, forKey: "landmark")
        newAddress.setValue(city.text, forKey: "city")
        newAddress.setValue(zipcode.text, forKey: "zipcode")
        newAddress.setValue(state.text, forKey: "state")
        newAddress.setValue(country.text, forKey: "country")
        let isValid = viewModel?.validate(Address(address: address.text, landmark: cityMain.text, city: city.text, state: state.text, country: country.text, zipcode: zipcode.text)) ?? false
       
        if isValid == true
        {
            do {
                try context.save()
                print("Saved.")
                retriveAddress()
            }catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func retriveAddress(){
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AddressEntity")
        do {
            let result = try context.fetch(fetchRequest) as! [AddressEntity]
            for data in result as [NSManagedObject] {
                print(data.value(forKey: "address") as! String)
            }
            let storyboard = UIStoryboard(name: "Address", bundle: nil)
            let addressListViewController = storyboard.instantiateViewController(withIdentifier: "AddressListViewController") as! AddressListViewController
            addressListViewController.result = result
            navigationController?.pushViewController(addressListViewController, animated: true)
        } catch {
            print("Failed")
        }
    }
}
extension AddAddressViewController: DidAddressCorrect {
    func didAddressGet(msg: String) {
        let alertController = UIAlertController(title: "Please Fill the Address Correctly", message: "\(msg)", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Handle OK action if needed
        }

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
}
