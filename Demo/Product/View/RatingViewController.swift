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
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var rating: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backBtnClicked(_ sender: UIButton) {
    }
    
    @IBAction func rateBtnClicked(_ sender: UIButton) {
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
