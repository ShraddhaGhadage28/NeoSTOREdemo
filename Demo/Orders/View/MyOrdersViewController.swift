//
//  MyOrdersViewController.swift
//  Demo
//
//  Created by Shraddha Ghadage on 04/09/2023.
//

import UIKit

class MyOrdersViewController: UIViewController {
    var viewModel: OrderListViewModel?
    var orderData: [OrderListData]?
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            tableView.register(UINib(nibName: "MyOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "MyOrdersTableViewCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.title = ""
        navigationItem.leftBarButtonItem = backButton
        NavigationManager.shared.navigationCustomBarUI(from: self)
        navigationItem.title = "My Orders"
        viewModel = OrderListViewModel()
        viewModel?.checkCartList()
        viewModel?.delegate = self
    }
    @objc func backButtonTapped() {
        // Handle back button tap
        navigationController?.popViewController(animated: true)
    }
}
extension MyOrdersViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrdersTableViewCell", for: indexPath) as! MyOrdersTableViewCell
        cell.selectionStyle = .none
        cell.orderId.text = "Order ID:\(orderData?[indexPath.row].id ?? 0)"
        cell.orderedDate.text = "Ordered Date:\(orderData?[indexPath.row].created ?? "")"
        cell.price.text = "₹.\(orderData?[indexPath.row].cost ?? 0)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Orders", bundle: nil)
        let OrderIdViewController = storyboard.instantiateViewController(withIdentifier: "OrderIdViewController") as! OrderIdViewController
        OrderIdViewController.orderId = orderData?[indexPath.row].id
        navigationController?.pushViewController(OrderIdViewController, animated: true)
    }
}
extension MyOrdersViewController:DidOrdertListArrived {
    func didOrderUpdated() {
        guard let data = viewModel?.orderDataArr else {
            return
        }
        self.orderData = data
        tableView.reloadData()
    }
}
