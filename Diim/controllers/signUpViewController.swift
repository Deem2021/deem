//
//  signUpViewController.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase
import SVProgressHUD
class signUpViewController: UIViewController,NavigationWithImage, CustomNavigationAppearance,UITextFieldDelegate {
    
    var databaseRefrence: DatabaseReference!
    
    @IBOutlet weak var password2: SkyFloatingLabelTextField!
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    @IBOutlet weak var phone: SkyFloatingLabelTextField!
    @IBOutlet weak var name: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainNavigationAppearance()
        setupNavigationImageView()
        setupFirebase()
        setupText(Textfield: password2)
        setupText(Textfield: password)
        setupText(Textfield: email)
        setupText(Textfield: phone)
        setupText(Textfield: name)
        
    }
    @IBAction func createAccount(_ sender: Any) {
        guard validateInput() else { return }
        signUser()
    }
    
    func setupFirebase(){
        databaseRefrence = Database.database().reference()
    }
    
    func validateInput() -> Bool{
        guard let userName = name.text ,
              let email = email.text ,
              let confirmPass = password2.text ,
              let password = password.text,
              let phoneNo = phone.text
        
        else {
            Utilities().showErrorAlert(self, message: "جميع الحقول مطلوبة")
            return false
        }
        
        if userName == "" || email == "" || confirmPass == "" || password == "" || phoneNo == ""{
            Utilities().showErrorAlert(self, message: "جميع الحقول مطلوبة")
            return false
            
        }
        if password != confirmPass {
            Utilities().showErrorAlert(self, message: "كلمة المرور غير متطابقة")
            return false
            
        }
        return true
    }
    
    func signUser(){
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) {(result , error) in
            if  error == nil && result != nil {
                SVProgressHUD.dismiss()
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.name.text
                changeRequest?.commitChanges { error in
                    if error == nil {
                        // move to the main page
                        DispatchQueue.main.async {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        }
                    }
                }
             else {
                if(error != nil){
                    Utilities().showErrorAlert(self, message: "Error : \(String(describing: error!.localizedDescription))")
                    return
                }
            }
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            
            let userDatabaserefrence = self.databaseRefrence.child("users").child(uid)
            let value = ["user_id": uid ,"user_name":self.name.text!,"phone":self.phone.text!,"email":self.email.text!]
            userDatabaserefrence.updateChildValues(value , withCompletionBlock : {(error , reference) in
                         if error != nil {
                             print(error)
                         }
                         else{
                            Defaults.save(userID: uid, userName:self.name.text ?? "nil")
                         }
                     })
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
        name.resignFirstResponder()
        password.resignFirstResponder()
        phone.resignFirstResponder()
        password2.resignFirstResponder()
        email.resignFirstResponder()
        
    }
}
