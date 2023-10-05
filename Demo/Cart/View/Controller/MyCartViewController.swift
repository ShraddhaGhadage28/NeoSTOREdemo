//
//  MyCartViewController.swift
//  Demo
//
//  Created by Shraddha Ghadage on 01/09/2023.
//

import UIKit


class MyCartViewController: UIViewController{

  
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            tableView.register(UINib(nibName: "MyCartTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCartTableViewCell")
            tableView.register(UINib(nibName: "CustomFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomFooterView")
        }
    }

    var viewModel : CartListViewModel?
    var viewModel1 : EditCartViewModel?
    var viewModel2 : DeleteCartViewModel?
    var cartArr : [CartListData]?
    var selectedIndex : String = ""
    var total : Int?
    var newSubTotal: Int?
    //var selectedDropDown: Int?
    let footerView = UIView()
    var cartItemCount : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CartListViewModel()
        viewModel1 = EditCartViewModel()
        viewModel2 = DeleteCartViewModel()
        viewModel?.delegate = self
        viewModel1?.delegate = self
        viewModel?.checkCartList()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
           backButton.title = ""
           navigationItem.leftBarButtonItem = backButton
        self.title = "My Cart"
        NavigationManager.shared.createNavigationBar(from: self, forType: .custom)
    }
    @objc func backButtonTapped() {
        // Handle back button tap
        navigationController?.popViewController(animated: true)
    }
    @objc func buttonTapped() {
        // Add your code to handle the button tap here
    }
    func cartCount() {
        cartItemCount = cartArr?.count ?? 0
        CartManager.shared.cartItemCount  = cartItemCount
        print(cartItemCount)
    }
}
extension MyCartViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartTableViewCell", for: indexPath) as! MyCartTableViewCell
        if let img = URL(string: cartArr?[indexPath.row].product?.productImages ?? "") {
            URLSession.shared.dataTask(with: img) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
                }
            }.resume()
        }
        cell.selectionStyle = .none
        cell.name.text = cartArr?[indexPath.row].product?.name ?? ""
        cell.category.text = "(Category - \(cartArr?[indexPath.row].product?.productCategory ?? ""))"
        cell.dropDown.text = "\(cartArr?[indexPath.row].quantity ?? 0)"
        cell.price.text = "₹.\(cartArr?[indexPath.row].product?.subTotal ?? 0)"
        cell.onDropdownSelection = { selectedItem in
            print("Selected item: \(selectedItem)")
            self.selectedIndex =  selectedItem
            let productId = self.cartArr?[indexPath.row].productId
            let param = editToCartCred(productId: productId, quantity: selectedItem)
            self.viewModel1?.checkEditedDataResponse(params: param)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if cartArr?.count == 0 || cartArr == nil{
            return nil
        }else{
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomFooterView") as! CustomFooterView
            footerView.totalAmount.text = "₹.\(total ?? 0)"
            footerView.orderNowButton.addTarget(self, action: #selector(pressOrderNow), for: .touchUpInside)
            return footerView
        }
    }
    
    @objc func pressOrderNow(){
            let storyboard = UIStoryboard(name: "Address", bundle: nil)
            let addressListViewController = storyboard.instantiateViewController(withIdentifier: "AddressListViewController") as! AddressListViewController
            navigationController?.pushViewController(addressListViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 200
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            cartArr?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
               
            if let productId = self?.cartArr?[indexPath.row].productId {
                self?.viewModel2?.checkDeletedDataResponse(productId: productId )
                self?.cartArr?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                GlobalInstance.shared.setCartCount(count: self?.cartArr?.count ?? 0)
                tableView.reloadData()
                
            }
            
                completionHandler(true)
            }

            if let binImage = UIImage(named: "delete") {
                deleteAction.image = binImage
            }
        
            deleteAction.backgroundColor = .white

            let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
            return swipeActions
    }
}
extension MyCartViewController: DidCartListArrived,DidEditedToCart {
    
    func didCartUpdated() {
        guard let data = viewModel?.cartDataArr else
        {
            return
        }
        guard let totalCount = viewModel?.total else
        {
            return
        }
        self.cartArr = data
        
        self.total = totalCount
        GlobalInstance.shared.setCartCount(count: cartArr?.count ?? 0)
        tableView.reloadData()
    }
    
    func didGetResponse(status: Int) {
        if (status == 200) {
            viewModel?.checkCartList()
        }
    }
    
    func didCartEmpty() {
        let alertController = UIAlertController(title: "Cart is Empty", message: "select Product", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
}
