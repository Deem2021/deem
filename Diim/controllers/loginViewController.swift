//
//  loginViewController.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField
import SVProgressHUD
class loginViewController: UIViewController,NavigationWithImage, CustomNavigationAppearance,UITextFieldDelegate {
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    var databaseRefrence: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainNavigationAppearance()
        setupNavigationImageView()
        setupFirebase()
        setupText(Textfield: password)
        setupText(Textfield: email)
    }
    func setupFirebase(){
        databaseRefrence = Database.database().reference()
    }
    @IBAction func login(_ sender: Any) {
        
        guard let email = email.text else { return }
        guard let pass = password.text else { return }
        SVProgressHUD.show()

        Auth.auth().signIn(withEmail: email, password: pass){ user , error in
            if error == nil && user != nil {
               SVProgressHUD.dismiss()
               let uID = Auth.auth().currentUser?.uid
                self.databaseRefrence.child("users").observe(.childAdded) { (snapshot) in
                   
                    if snapshot.key == uID {
                        if let dectionary = snapshot.value as? [String:AnyObject] {
                        let name = dectionary["user_name"] as? String
                        let uid = dectionary["user_id"] as? String
                            Defaults.save(userID: uid ?? "nil", userName:name ?? "nil")
                        self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                }
                
            } else {
                Utilities().showErrorAlert(self, message: "فضلا تأكد من بياناتك المدخلة")
            }
        }
    }
    func setupText(Textfield: SkyFloatingLabelTextField){
        Textfield.delegate = self
        Textfield.isLTRLanguage = false
        Textfield.font = UIFont.textStyle14
        Textfield.titleFont = UIFont.textStyle14
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    @objc func hideKeyboard(tapGestureRecognizer: UITapGestureRecognizer) {
        password.resignFirstResponder()
        email.resignFirstResponder()

    }
}
