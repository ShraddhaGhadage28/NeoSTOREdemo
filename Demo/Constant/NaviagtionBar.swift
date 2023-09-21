//
//  NaviagtionBar.swift
//  NeoStore
//
//  Created by Shraddha Ghadage on 28/08/2023.
//

import Foundation
import UIKit
import SideMenu

class NavigationManager {
        //let sideMenuVC = HomeViewController()
    var isLeftBarTapped: ((Bool)->Void)?
    
        static let shared = NavigationManager()
        // Singleton instance

        private init() {
            
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        func navigationBarUI(from sourceViewController: UIViewController) {
            let customBackButton = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .plain, target: self, action: #selector(menuSlider))
            customBackButton.tintColor = UIColor.white
            let customSearchButton = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(searchBtn))
            customSearchButton.tintColor = UIColor.white
            sourceViewController.navigationItem.leftBarButtonItem = customBackButton
            sourceViewController.navigationItem.rightBarButtonItem = customSearchButton
        }
        func navigationRegiserBarUI(from sourceViewController: UIViewController) {
            sourceViewController.navigationController?.navigationBar.tintColor = UIColor.white
            sourceViewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
       
        func navigationCustomBarUI(from sourceViewController: UIViewController) {
            // Customize the appearance of the back button arrow color
            sourceViewController.navigationController?.navigationBar.tintColor = UIColor.white
            // Hide the back button title for the next view controller
            sourceViewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            let customSearchButton = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(searchBtn))
            customSearchButton.tintColor = UIColor.white
            sourceViewController.navigationItem.rightBarButtonItem = customSearchButton
        }
    func navigationAddressBarUI(from sourceViewController: UIViewController) {
        sourceViewController.navigationController?.navigationBar.tintColor = UIColor.white
        sourceViewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
        @objc func menuSlider() {
           // sideMenuVC.loadSideMenu()
            isLeftBarTapped?(true)
        }
        @objc func searchBtn() {
            
        }
    }




