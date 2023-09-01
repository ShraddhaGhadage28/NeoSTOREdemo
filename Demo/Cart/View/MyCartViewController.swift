//
//  MyCartViewController.swift
//  Demo
//
//  Created by Shraddha Ghadage on 01/09/2023.
//

import UIKit

class MyCartViewController: UIViewController {

  
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            tableView.register(UINib(nibName: "MyCartTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCartTableViewCell")
        }
    }

    var viewModel : CartListViewModel?
    var cartArr : [CartListData]?
    
    let button = UIButton(type: .system)
    let footerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CartListViewModel()
        viewModel?.delegate = self
        viewModel?.checkCartList()
       // buttonOrderNow()
    }
    func buttonOrderNow() {
        button.setTitle("Order Now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        footerView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // You can set constraints for the button as needed.
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])
        tableView.tableFooterView = footerView
    }
    @objc func buttonTapped() {
        // Add your code to handle the button tap here
    }
}
extension MyCartViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartTableViewCell", for: indexPath) as! MyCartTableViewCell
        cell.name.text = cartArr?[indexPath.row].product?.name ?? ""
        cell.category.text = cartArr?[indexPath.row].product?.productCategory
        return cell
    }
    
    
}
extension MyCartViewController: DidCartListArrived {
    func didCartUpdated() {
        guard let data = viewModel?.cartDataArr else
        {
            return
        }
        self.cartArr = data
        tableView.reloadData()
    }
}
