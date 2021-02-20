//
//  menuViewController.swift
//  Diim
//
//  Created by Diim on 19/02/2021.
//

import UIKit

class menuViewController: UIViewController,NavigationWithImage,CustomNavigationAppearance {
    
    @IBOutlet weak var ordersAchevments: UIButton!
    @IBOutlet weak var aboutUs: UIButton!
    @IBOutlet weak var profile: UIButton!
    @IBOutlet weak var logout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainNavigationAppearance()
        checkIsRegister()
    }
    override func viewWillAppear(_ animated: Bool) {
        checkIsRegister()
        
    }
    
    @IBAction func profile(_ sender: Any) {
        
        if Defaults.isUserLogedIn() {
            let profile = self.storyboard?.instantiateViewController(withIdentifier: "profileViewController") as! profileViewController
            self.navigationController?.pushViewController(profile, animated: true)
        }
        else{
            let login = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
            self.navigationController?.pushViewController(login, animated: true)
        }
        
    }
    @IBAction func about(_ sender: Any) {
        let aboutus = self.storyboard?.instantiateViewController(withIdentifier: "aboutUsViewController") as! aboutUsViewController
        self.navigationController?.pushViewController(aboutus, animated: true)
    }
    
    @IBAction func ordersAchPage(_ sender: Any) {
        
    }
    @IBAction func logout(_ sender: Any) {
        Defaults.clearUserData()
        logout.isHidden = true
        let attributedStringButton = NSMutableAttributedString(string: "تسجيل الدخول", attributes: [
            .font: UIFont.textStyle18,
            .foregroundColor: UIColor.melon
        ])
        profile.setAttributedTitle(attributedStringButton, for: .normal)
        Utilities().showSuccessAlert(self, message: "تسجيل خروجك بنجاح")
    }
    
    func checkIsRegister(){
        if !Defaults.isUserLogedIn() {
            logout.isHidden = true
            let attributedStringButton = NSMutableAttributedString(string: "تسجيل الدخول", attributes: [
                .font: UIFont.textStyle18,
                .foregroundColor: UIColor.melon
            ])
            profile.setAttributedTitle(attributedStringButton, for: .normal)
        }
        else{
            logout.isHidden = false
            let attributedStringButton = NSMutableAttributedString(string: "الملف الشخصي", attributes: [
                .font: UIFont.textStyle18,
                .foregroundColor:  UIColor.melon
            ])
            profile.setAttributedTitle(attributedStringButton, for: .normal)
        }
    }
    
}
