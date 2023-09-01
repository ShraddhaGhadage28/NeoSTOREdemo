//
//  QuantityPopUpViewController.swift
//  Demo
//
//  Created by Shraddha Ghadage on 31/08/2023.
//

import UIKit

protocol PopupDelegate: AnyObject {
    func didSubmitFromPopup()
}

class QuantityPopUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var name: UILabel!
    var data:String = ""
    var imgUrl: String?
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var quantity: UITextField!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var View1: UIView!
    weak var delegate: PopupDelegate?
    var viewModel: AddToCartViewModel?

    init() {
        super.init(nibName: "QuantityPopUpViewController", bundle: nil)
//        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddToCartViewModel()
        viewModel?.delegate = self
        let contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 40, right: 0)
                scrollView.contentInset = contentInset
        View1.layer.borderWidth = 2.0
        View1.layer.borderColor = UIColor.lightGray.cgColor
        quantity.layer.borderWidth = 2.0
        quantity.layer.borderColor = UIColor.green.cgColor
        quantity.delegate = self
        name.text = data
        setImage()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           quantity.resignFirstResponder()
           return true
       }
    func setImage(){
        if let imageUrl = URL(string: imgUrl ?? "") {
            if let imageData = try? Data(contentsOf: imageUrl) {
            DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        self.imgView.image = image
                    }
                }
            }
        }
    }
    
    @IBAction func submitBtnClicked(_ sender: UIButton) {
        let param = addToCartCred(productId: 1, quantity: 3)
        viewModel?.checkDataResponse(params: param)

    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

}
extension QuantityPopUpViewController: DidAddedToCart {
    func didGetRes(msg: String,userMsg: String,status:Int) {
        let alertController = UIAlertController(title: "\(msg)", message: "\(userMsg)", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if (status == 200)
            {
                self.delegate?.didSubmitFromPopup()
            }
        }

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
}
