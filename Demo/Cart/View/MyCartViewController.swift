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
    var selectedIndex : String = ""
    let footerView = UIView()
    var cartItemCount : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.navigationCustomBarUI(from: self)
        self.title = "My Cart"
        navigationItem.leftBarButtonItem?.title = ""
        viewModel = CartListViewModel()
        viewModel?.delegate = self
        viewModel?.checkCartList()
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
        cell.name.text = cartArr?[indexPath.row].product?.name ?? ""
        cell.category.text = "(Category - \(cartArr?[indexPath.row].product?.productCategory ?? ""))"
        cell.dropDown.text = "\(cartArr?[indexPath.row].quantity ?? 0)"
        cell.onDropdownSelection = { selectedItem in
                print("Selected item: \(selectedItem)")
            self.selectedIndex =  selectedItem
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60))
        let button = UIButton()
        button.frame = footerView.frame
        button.setTitle("Order Now", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        footerView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    // Center the button horizontally and vertically within the footer view
                    button.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
                    button.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
                    button.widthAnchor.constraint(equalToConstant: 370),
                    button.heightAnchor.constraint(equalToConstant: 60)
                ])
        
        return footerView
    }
    
}
extension MyCartViewController: DidCartListArrived {
    func didCartUpdated() {
        guard let data = viewModel?.cartDataArr else
        {
            return
        }
        self.cartArr = data
        GlobalInstance.shared.setCartCount(count: cartArr?.count ?? 0)
        tableView.reloadData()
    }
}
