//
//  QuantityPopUpViewController.swift
//  Demo
//
//  Created by Shraddha Ghadage on 31/08/2023.
//

import UIKit


class QuantityPopUpViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var name: UILabel!
    var data:String = ""
    var imgUrl: String?
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var quantity: UITextField!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var View1: UIView!
    init() {
        super.init(nibName: "QuantityPopUpViewController", bundle: nil)
//        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 40, right: 0)
                scrollView.contentInset = contentInset
        View1.layer.borderWidth = 2.0
        View1.layer.borderColor = UIColor.lightGray.cgColor
        quantity.layer.borderWidth = 2.0
        quantity.layer.borderColor = UIColor.green.cgColor
        name.text = data
        setImage()
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
        
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
