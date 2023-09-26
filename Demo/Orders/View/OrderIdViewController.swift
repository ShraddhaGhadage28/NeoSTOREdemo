//
//  OrderIdViewController.swift
//  Demo
//
//  Created by Shraddha Ghadage on 04/09/2023.
//

import UIKit

class OrderIdViewController: UIViewController {
    var orderId:Int?
    var price: Int?
    var orderData:[OrderDetails]?
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "OrderIdTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderIdTableViewCell")
            tableView.register(UINib(nibName: "OrderIdFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "OrderIdFooterView")
        }
    }
    var viewModel:OrderDetailViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.navigationCustomBarUI(from: self)
        navigationItem.title = "Order ID : \(orderId ?? 0)"
        viewModel = OrderDetailViewModel()
        viewModel?.delegate = self
        viewModel?.checkGetData(id: orderId ?? 0)
    }
}
extension OrderIdViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderIdTableViewCell", for: indexPath) as! OrderIdTableViewCell
        cell.selectionStyle = .none
        if let img = URL(string: orderData?[indexPath.row].prodImage ?? "") {
            URLSession.shared.dataTask(with: img) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                        
                    }
                }
            }.resume()
        }
        cell.name.text = orderData?[indexPath.row].prodName
        cell.category.text = "(\(orderData?[indexPath.row].prodCatName ?? ""))"
        cell.quantity.text = "QTY : \(orderData?[indexPath.row].quantity ?? 0)"
        cell.price.text = "₹.\(orderData?[indexPath.row].total ?? 0)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OrderIdFooterView") as! OrderIdFooterView
        footerView.totalCost.text = "₹. \(price ?? 0)"
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}
extension OrderIdViewController: OrderDataPassing {
    func orderPass() {
        guard let data = viewModel?.dataArr else {
            return
        }
        self.orderData = data
        self.price = viewModel?.cost
        tableView.reloadData()
    }
}
