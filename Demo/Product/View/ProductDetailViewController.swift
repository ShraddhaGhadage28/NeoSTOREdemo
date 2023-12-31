//
//  ProductDetailViewController.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 23/08/2023.
//

import UIKit
import Cosmos
import Foundation
class ProductDetailViewController: UIViewController {
    
//    MARK: -  IBOutlets
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var producer: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var starsView: CosmosView!
    @IBOutlet weak var productImgDetail: UIImageView!
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    var popUp: QuantityPopUpViewController?
    var ratePopUp: RatingViewController?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "ProductDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailsCollectionViewCell")
        }
    }
    
   
    //    MARK: -  Variable Declaration
    var data: ProductDetailsData?
    var productId:Int?
    var viewmodel: ProductDetailViewModel?
    //    MARK: -  Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.createNavigationBar(from: self, forType: .custom)
        productTitle.adjustsFontSizeToFitWidth = true
        productTitle.minimumScaleFactor = 0.5
        viewmodel = ProductDetailViewModel()
        viewmodel?.delegate = self
        //cellData()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        viewmodel?.checkGetData(id: productId ?? 0)
    }
    func cellData()
    {
        productTitle.text = data?.name
        let categoryId = data?.productCategoryId
        switch categoryId {
        case 1: category.text = "Category - Table"
        case 2: category.text = "Category - Chairs"
        case 3: category.text = "Category - Sofas"
        case 4: category.text = "Category - Cupboards"
        default:
            return
        }
        producer.text = data?.producer
        cost.text = "Rs. \(data?.cost ?? 0)"
        if let img = URL(string: data?.productImages?.first?.image ?? "") {
            URLSession.shared.dataTask(with: img) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.productImgDetail.image = image
                    }
                }
            }.resume()
        }
        setupWithRating(data?.rating ?? 0)
        detailDescription.text = data?.description
    }
    
   
    func setupWithRating(_ rating: Int) {
        starsView.settings.updateOnTouch = false
        starsView.settings.starSize = 18
        starsView.settings.emptyBorderColor = UIColor.lightGray
        starsView.settings.emptyColor = UIColor.lightGray
        starsView.rating = Double(rating)
        }
    @IBAction func buyNowClicked(_ sender: UIButton) {
        popUp = QuantityPopUpViewController()
        popUp?.modalPresentationStyle = .overFullScreen
        popUp?.delegate = self
        popUp?.data = data?.name ?? ""
        popUp?.productId = data?.id ?? 0
        if let imageUrl = data?.productImages?.first?.image {
            popUp?.imgUrl = imageUrl
        }
        self.present(popUp ?? UIViewController(),animated: true,completion: nil)
    }
    
    @IBAction func rateBtnClicked(_ sender: UIButton) {
        ratePopUp = RatingViewController()
        ratePopUp?.modalPresentationStyle = .overFullScreen
        ratePopUp?.data = data?.name ?? ""
        ratePopUp?.productId = data?.id ?? 0
        if let imageUrl = data?.productImages?.first?.image {
            ratePopUp?.imgUrl = imageUrl
        }
        self.present(ratePopUp ?? UIViewController(),animated: true,completion: nil)
    }
    
}

extension ProductDetailViewController :UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.productImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCollectionViewCell", for: indexPath) as? ProductDetailsCollectionViewCell
        
        if let img = URL(string: data?.productImages?[indexPath.item].image ?? "") {
            URLSession.shared.dataTask(with: img) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        // Update your UIImageView with the downloaded image
                        cell?.imgView.image = image
                        
                        //self.productImgDetail.image = image
                    }
                }
            }.resume()
        }
            return cell ?? UICollectionViewCell()
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let img = URL(string: data?.productImages?[indexPath.row].image ?? "") {
            URLSession.shared.dataTask(with: img) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.productImgDetail.image = image
                    }
                }
            }.resume()
        }
//        if let imageUrl = URL(string: data?.productImages?[indexPath.row].image ?? "") {
//            DispatchQueue.main.async {
//                if let imageData = try? Data(contentsOf: imageUrl) {
//                    if let image = UIImage(data: imageData) {
//                        self.productImgDetail.image = image
//                    }
//                }
//            }
//
//       }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
           return CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.height)
       }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10        }
    
}

extension ProductDetailViewController: DataPassing {
    func dataPass() {
        guard let data = viewmodel?.dataInDetail else
        {
            return
        }
        self.data = data
        cellData()
        self.title = data.name
        let frame = CGRect(x: 0, y: 0, width: 200, height: 40)
            let tlabel = UILabel(frame: frame)
            tlabel.text = self.title
            tlabel.textColor = UIColor.white
            tlabel.font = UIFont.boldSystemFont(ofSize: 24)
            tlabel.backgroundColor = UIColor.clear
            tlabel.adjustsFontSizeToFitWidth = true
            tlabel.textAlignment = .center
            self.navigationItem.titleView = tlabel
        collectionView.reloadData()
    }
    
}

extension ProductDetailViewController: PopupDelegate {
    func didSubmitFromPopup() {
        popUp?.dismiss(animated: true)
            let storyboard = UIStoryboard(name: "Home", bundle: nil) // Replace "Main" with your storyboard name
            let myCartViewController = storyboard.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            navigationController?.pushViewController(myCartViewController, animated: true)
        }
        
}

struct ImageModel {
    var image: UIImage
    var isSelected: Bool
}
