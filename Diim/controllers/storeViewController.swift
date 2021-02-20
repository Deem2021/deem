//
//  storeViewController.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import UIKit
import SideMenu

class storeViewController: UIViewController ,NavigationWithImage, CustomNavigationAppearance,CustomMenuButtonItem {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainNavigationAppearance()
        setupNavigationImageView()
        setupCustomMenuButton()
    }
    
    func didPressMenuBtn() {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
}
