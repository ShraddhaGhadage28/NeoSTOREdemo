//
//  RatingViewController.swift
//  Demo
//
//  Created by Shraddha Ghadage on 02/09/2023.
//

import UIKit
import Cosmos

class RatingViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var rating: CosmosView!
    var data:String = ""
    var imgUrl: String?
    var productId: Int?
    var updatedRating: Int?
    var viewModel: SetRatingViewModel?
    var selectedRating : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = data
        setImage()
        rating.settings.starSize = 40
        rating.didTouchCosmos = { rating in
            self.selectedRating = Int(rating)
            print("User selected rating: \(self.selectedRating)")
            
        }
        viewModel = SetRatingViewModel()
        viewModel?.delegate = self
    }
    func setImage(){
        if let img = URL(string: imgUrl ?? "") {
            URLSession.shared.dataTask(with: img) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imgView.image = image
                    }
                }
            }.resume()
            //        if let imageUrl = URL(string: imgUrl ?? "") {
            //            if let imageData = try? Data(contentsOf: imageUrl) {
            //            DispatchQueue.main.async {
            //                    if let image = UIImage(data: imageData) {
            //                        self.imgView.image = image
            //                    }
            //                }
            //            }
            //        }
        }
    }
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func rateBtnClicked(_ sender: UIButton) {
        
        viewModel?.checkRatingData(productId:productId ?? 0 , rating: selectedRating ?? 0)
    }
}
extension RatingViewController: RatingRes  {
    func didRatingSet(msg: String, userMsg: String) {
        let alertController = UIAlertController(title: "\(msg)", message: "\(userMsg)", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true)
        }

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

