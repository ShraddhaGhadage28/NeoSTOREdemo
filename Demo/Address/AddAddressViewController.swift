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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.navigationCustomBarUI(from: self)
        navigationItem.title = "Add Address"
    }
    

    @IBAction func saveBtnClicked(_ sender: UIButton) {
    
        let addressEntity = NSEntityDescription.entity(forEntityName: "AddressEntity",in: context)!
        let address = NSManagedObject(entity: addressEntity, insertInto: context)
        address.setValue("Sangli", forKey: "address")
        address.setValue("Vrushali Hotel", forKey: "landmark")
        address.setValue("Navi Mumbai", forKey: "city")
        address.setValue("400701", forKey: "zipcode")
        address.setValue("MH", forKey: "state")
        address.setValue("Bharat", forKey: "country")
        
        //addressData.address = address.text
//        addressData.landmark = cityMain.text
//        addressData.city = city.text
//        addressData.state = state.text
//        addressData.country = country.text
        
        do {
            try context.save()
            print("Saved.")
            retriveAddress()
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
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
