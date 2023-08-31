//
//  SideMenuViewController.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 29/08/2023.
//

import UIKit


class SideMenuViewController: UIViewController {
    @IBOutlet weak var sideMenuTableView: UITableView! {
        didSet {
            sideMenuTableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        }
    }
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
 
    
    var viewModel : SideMenuViewModel?
    var menu: DataClass?
    //var productId:Int
    var productCategoryArr :[ProductCategory]?
    var menuArr = ["My Cart","Tables","Chairs","Sofas","Cupboards","My Account","Store Locator","My Orders","Logout"]
    var menuImgArr = [UIImage(named: "shoppingcart_icon"),UIImage(named: "tables_icon"),UIImage(named: "chair"),UIImage(named: "sofa_icon"),UIImage(named: "cupboard"),UIImage(named: "username_icon"),UIImage(named: "storelocator_icon"),UIImage(named: "myorders_icon"),UIImage(named: "logout_icon")]
   

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SideMenuViewModel()
        viewModel?.delegate = self
        viewModel?.checkGetData()
    }
    func menuLoader() {
        profileImg.layer.masksToBounds = true
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg?.layer.borderWidth = 3.0
        profileImg?.layer.borderColor = UIColor.white.cgColor

        name.text = "\(menu?.userData.firstName ?? "") \(menu?.userData.lastName ?? "")" 
        email.text = menu?.userData.email
    }
//    func productIdPassing(title:String) -> Int
//    {
//        switch title {
//        case "Tables":  productId = 1
//            return productId
//        case "Chairs": productId = 2
//            return productId
//        case "Sofas": productId = 3
//            return productId
//        case "Cupboards": productId = 4
//            return productId
//        default:
//            return 0
//        }
//    }
    func didSelectMenuItem(id:Int) {
        
           let productVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "VC") as! ProductViewController
           productVC.productId = id
           navigationController?.pushViewController(productVC, animated: true)
           
    }

}
extension SideMenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return menu?.productCategories.count ?? 0
        return menuImgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
       
        cell.imgView.image = menuImgArr[indexPath.row]
        cell.menuLabel.text = menuArr[indexPath.row]
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row{
        case 1,2,3,4:
            let index = viewModel?.dataArr?.productCategories[indexPath.row-1].id
            didSelectMenuItem(id: index ?? 0)

        default:
            return
        }
        let selectedItem = menuArr[indexPath.row]
//        var index = viewModel?.dataArr?.productCategories[indexPath.row-1].id
//        var index = productCategoryArr?[indexPath.row].id
//        print(index)
//        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    }
    
    

extension SideMenuViewController: DataPass {
    func dataPassing() {
        guard let data = viewModel?.dataArr else { return }
        self.menu = data
        menuLoader()
        sideMenuTableView.reloadData()
        var index = menu?.productCategories.count
        print(index)
    }
}


