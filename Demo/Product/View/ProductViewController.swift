//
//  ProductViewController.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 22/08/2023.
//

import UIKit
import Foundation
import Cosmos


class ProductViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    var ratings: [Int] = [0,1,2,3,4,5]
    
    var viewmodel : ProductViewModel?
    var productArr: [ProductData]?
    var productId:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.navigationCustomBarUI(from: self)
        viewmodel = ProductViewModel()
        viewmodel?.delegate = self
        viewmodel?.checkGetData(id: productId ?? 0)
    }
    func NavBarTitleSetting(id:Int)
    {
        switch id {
        case 1:navigationItem.title = "Tables"
        case 2:navigationItem.title = "Chairs"
        case 3:navigationItem.title = "Sofas"
        case 4:navigationItem.title = "Cupboards"
        default:
            return 
        }
    }
    @objc func searchBtn()
    {
        
    }
    func navigationBar()
    {
        
    }
    
    
    
}

extension ProductViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        let index = indexPath.row
        NavBarTitleSetting(id: productArr?[index].productCategoryId ?? 0)
       
        cell.title.text = productArr?[index].name
        if let img = URL(string: productArr?[index].productImages ?? "") {
            URLSession.shared.dataTask(with: img) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        // Update your UIImageView with the downloaded image
                        cell.imgView.image = image
                        
                    }
                }
            }.resume()
           
        }
        cell.producer.text = productArr?[index].producer
        cell.price.text = "RS.\(productArr?[index].cost ?? 0)"
        cell.configureWithRating(productArr?[index].rating ?? 0)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = productArr?[indexPath.row].id ?? 0
        print(index)
        if let productDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            //productDetailVC.dataArr = productArr?[indexPath.row]
            productDetailVC.productId = index
            self.navigationController?.pushViewController(productDetailVC, animated: true)
            
            
        }
    }
}

extension ProductViewController: DataPassing {
    func dataPass() {
        guard let data = viewmodel?.dataArr else
        {
            return
        }
        self.productArr = data
        productTableView.reloadData()
    }
    
}


