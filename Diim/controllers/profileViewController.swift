//
//  profileViewController.swift
//  Diim
//
//  Created by Diim on 20/02/2021.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField
import SVProgressHUD
class profileViewController: UIViewController,CustomNavigationAppearance {
    
    var databaseRefrence: DatabaseReference!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var phone: SkyFloatingLabelTextField!
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    @IBOutlet weak var name: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainAppearance()
        let font = UIFont.textStyle18
        navigationController?.navigationBar.titleTextAttributes = [.font: font,   .foregroundColor: UIColor.aquaBlue]
        self.navigationController?.title = "الملف الشخصي"
        self.title = "الملف الشخصي"
        getDataFromFirebase()
        setupText(Textfield: phone)
        setupText(Textfield: email)
        setupText(Textfield: name)
        view1.applyShadowView1()
    }
    func setupText(Textfield: SkyFloatingLabelTextField){
        Textfield.isLTRLanguage = false
        Textfield.font = UIFont.textStyle18
        Textfield.titleFont = UIFont.textStyle18
      //  Textfield.isEnabled = false
        Textfield.isUserInteractionEnabled = false
    }

    func getDataFromFirebase(){
        SVProgressHUD.show()
        databaseRefrence = Database.database().reference()
        let uID = Auth.auth().currentUser?.uid
        databaseRefrence.child("users").child(uID!).observe(.value) { (snapshots:DataSnapshot) in
            SVProgressHUD.dismiss()
            if let dectionary = snapshots.value as? [String:AnyObject] {
                let name = dectionary["user_name"] as? String
                let phone = dectionary["phone"] as? String
                let email = dectionary["email"] as? String
                self.name.text = name ?? ""
                self.phone.text = phone ?? ""
                let achievements = dectionary["achievements"] as? [String:AnyObject]
                self.points.text = achievements?["points"] as? String
                self.email.text =  email ?? ""

                
            }
        }
    }
    
    
    
}
