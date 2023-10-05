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
    var viewModel1 : GetAccountDetailsViewModel?
    var menu: DataClass?
    var updatedCart: String = ""
    var productCategoryArr :[ProductCategory]?
    var menuArr = ["My Cart","Tables","Chairs","Sofas","Cupboards","My Account","Store Locator","My Orders","Logout"]
    var menuImgArr = [UIImage(named: "shoppingcart_icon"),UIImage(named: "tables_icon"),UIImage(named: "chair"),UIImage(named: "sofa_icon"),UIImage(named: "cupboard"),UIImage(named: "username_icon"),UIImage(named: "storelocator_icon"),UIImage(named: "myorders_icon"),UIImage(named: "logout_icon")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SideMenuViewModel()
        viewModel?.delegate = self
        viewModel1 = GetAccountDetailsViewModel()
        viewModel?.checkGetData()
        updatedCart = "\(GlobalInstance.shared.getCartCount())"
    }
    func menuLoader() {
        profileImg.layer.masksToBounds = true
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg?.layer.borderWidth = 3.0
        profileImg?.layer.borderColor = UIColor.white.cgColor
        name.text = "\(menu?.userData.firstName ?? "") \(menu?.userData.lastName ?? "")"
        email.text = menu?.userData.email
        if let img = URL(string: menu?.userData.profilePic ?? "") {
            URLSession.shared.dataTask(with: img) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.profileImg.image = image
                    }
                }
            }.resume()
        }
    }
    
    func didSelectMenuItem(id:Int) {
        let productVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        productVC.productId = id
        self.navigationItem.title = ""
        navigationController?.pushViewController(productVC, animated: true)
        
    }
    
}
extension SideMenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuImgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
        cell.selectionStyle = .none
        cell.imgView.image = menuImgArr[indexPath.row]
        cell.menuLabel.text = menuArr[indexPath.row]
        if indexPath.row == 0 {
            cell.addToCartLabel.text = updatedCart
            cell.badgeView.isHidden = false
        } else
        {
            cell.badgeView.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            let vc = MyCartViewController.instantiate(appStoryboard: .home)
            viewModel1?.checkUserDataResponse()
            navigationController?.pushViewController(vc, animated: true)
        case 1,2,3,4:
            let index = viewModel?.dataArr?.productCategories[indexPath.row-1].id
            didSelectMenuItem(id: index ?? 0)
        case 5:
            let vc = EditProfileViewController.instantiate(appStoryboard: .account)
            navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = StoreLocatorViewController.instantiate(appStoryboard: .storeLocator)
            navigationController?.pushViewController(vc, animated: true)
        case 7:
            let vc = MyOrdersViewController.instantiate(appStoryboard: .orders)
            navigationController?.pushViewController(vc, animated: true)
        case 8:
            let vc = LoginViewController.instantiate(appStoryboard: .main)
            GlobalInstance.shared.setAccessToken(accessToken: "")
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
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
    }
}


