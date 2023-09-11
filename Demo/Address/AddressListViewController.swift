//
//  AddressListViewController.swift
//  Demo
//
//  Created by Shraddha Ghadage on 02/09/2023.
//

import UIKit
import CoreData

class AddressListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "AddressListTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressListTableViewCell")
        }
    }
    var result: [AddressEntity] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.navigationAddressBarUI(from: self)
        navigationItem.title = "Address List"
        let customSearchButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAddress))
        self.navigationController?.navigationItem.rightBarButtonItem = customSearchButton
        customSearchButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = customSearchButton
    }
    
    func deleteData(address:AddressEntity) {
        
        do {
            context.delete(address)
            do {
                try context.save()
            } catch {
                print("Error deleting data: \(error)")
            }
        } catch {
            print("Error fetching data for deletion: \(error)")
        }
        
    }
}
extension AddressListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListTableViewCell", for: indexPath) as! AddressListTableViewCell
        let allAddress = "\(result[indexPath.row].address ?? "") , \(result[indexPath.row].landmark ?? "") , \(result[indexPath.row].city ?? "") , \(result[indexPath.row].state ?? "") , \(result[indexPath.row].country ?? "") , \(result[indexPath.row].zipcode ?? "")"
        cell.setup(useNname: result[indexPath.row].country,
                   userAddress: allAddress)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            result.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let adr = self.result[indexPath.row]
            self.result.remove(at: indexPath.row)
            self.deleteData(address: adr)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            completionHandler(true) // Indicates that the action was performed
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    @objc func addAddress() {
        let storyboard = UIStoryboard(name: "Address", bundle: nil)
        let addAddressViewController = storyboard.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        navigationController?.pushViewController(addAddressViewController, animated: true)
    }
}
