//
//  ViewController.swift
//  Diim
//
//  Created by Fatima Aljaber on 18/02/2021.
//

import UIKit
import SwiftIcons
class MyTabBarCtrl: UITabBarController, UITabBarControllerDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupMiddleButton()
    }
    
    // TabBarButton – Setup Middle Button
    func setupMiddleButton() {
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-29, y: -35, width: 60, height: 60))
        middleBtn.layer.cornerRadius = 30
            middleBtn.setImage(UIImage(named: "plus"), for: .normal)
        middleBtn.backgroundColor = UIColor.melon
        
        //STYLE THE BUTTON YOUR OWN WAY
        //   let gradientLayer = CAGradientLayer()
        //    middleBtn.layer.masksToBounds = true
        //    gradientLayer.frame = middleBtn.bounds
        //    let topGradientColor = UIColor(red: 133.0/255.0, green: 168.0/255.0, blue: 134.0/255.0, alpha: 1.0)
        //    let bottomGradientColor = UIColor(red: 160.0/255.0, green: 207.0/255.0, blue: 162.0/255.0, alpha: 1.0)
        //    gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
        //    middleBtn.layer.insertSublayer(gradientLayer, at: 0)
        // middleBtn.setIcon(icon: .fontAwesomeSolid(.plus), iconSize: 15.0, color: UIColor.white, backgroundColor: bottomGradientColor, forState: .normal)
        
        
        //add to the tabbar and add click event
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            if tabBarController.selectedIndex == 2{
               
                
            }
        
    }
   
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 2   //to select the middle tab. use "1" if you have only 3 tabs.
       
    }
    
}
