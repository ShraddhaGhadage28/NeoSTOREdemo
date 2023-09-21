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
            tableView.register(UINib(nibName: "AddressFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "AddressFooterView")
        }
    }
    var viewModel : PlaceOrderViewModel?
    var result: [AddressEntity] = []
    var allAddress : String?
    var selectedAddress: String?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.navigationAddressBarUI(from: self)
        navigationItem.title = "Address List"
        let customSearchButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAddress))
        self.navigationController?.navigationItem.rightBarButtonItem = customSearchButton
        customSearchButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = customSearchButton
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AddressEntity")
         do {
             let newResult = try context.fetch(fetchRequest) as! [AddressEntity]
             for data in newResult as [NSManagedObject] {
                 print(data.value(forKey: "address") as! String)
                 result = newResult
             }
         } catch {
             print("Failed")
         }
        viewModel = PlaceOrderViewModel()
        viewModel?.delegate = self
    }
    
    func deleteData(address:AddressEntity) {
        do {
            context.delete(address)
            do {
                try context.save()
            } catch {
                print("Error deleting data: \(error)")
            }
        }
//        catch {
//            print("Error fetching data for deletion: \(error)")
//        }
    }
   
}
extension AddressListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListTableViewCell", for: indexPath) as! AddressListTableViewCell
        allAddress = "\(result[indexPath.row].address ?? "") , \(result[indexPath.row].landmark ?? "") , \(result[indexPath.row].city ?? "") , \(result[indexPath.row].state ?? "") , \(result[indexPath.row].country ?? "") , \(result[indexPath.row].zipcode ?? "")"
        cell.setup(useNname: result[indexPath.row].country,
                   userAddress: allAddress)
        let adr = self.result[indexPath.row]
        cell.onClickClearBtn = {
            self.result.remove(at: indexPath.row)
            self.deleteData(address: adr)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
               }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cells visible on screen we can deselect it
           for visibleIndexPath in tableView.indexPathsForVisibleRows ?? [] {
               if visibleIndexPath != indexPath {
                   let cell = tableView.cellForRow(at: visibleIndexPath) as! AddressListTableViewCell
                   cell.selectBtnClicked(selected: false)
               }
           }
           let cell = tableView.cellForRow(at: indexPath) as! AddressListTableViewCell
           cell.selectBtnClicked(selected: true)
           selectedAddress = cell.address.text
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
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AddressFooterView") as! AddressFooterView
        footerView.placeOrder.addTarget(self, action: #selector(pressOrderNow), for: .touchUpInside)
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    @objc func pressOrderNow(){
        if selectedAddress == nil {
            let alertController = UIAlertController(title: "Address is Missing", message: "Select address", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                alertController.dismiss(animated: true)
            }
            alertController.addAction(okAction)

            self.present(alertController, animated: true, completion: nil)
        } else {
            viewModel?.checkUserDataResponse(address: selectedAddress ?? "")
        }
    }
    @objc func addAddress() {
        let storyboard = UIStoryboard(name: "Address", bundle: nil)
        let addAddressViewController = storyboard.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        navigationController?.pushViewController(addAddressViewController, animated: true)
    }
}
extension AddressListViewController:DidOrderFetched {
    func didGetOrder(status: Int, msg: String, userMsg: String) {
        if (status == 200)
        {
            let alertController = UIAlertController(title: "\(msg)", message: "\(userMsg)", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                let storyboard = UIStoryboard(name: "Orders", bundle: nil)
                let ordersListViewController = storyboard.instantiateViewController(withIdentifier: "MyOrdersViewController") as! MyOrdersViewController
               // ordersListViewController.address = self.allAddress
                self.navigationController?.pushViewController(ordersListViewController, animated: true)
            }

            alertController.addAction(okAction)

            self.present(alertController, animated: true, completion: nil)
        }
    }
}