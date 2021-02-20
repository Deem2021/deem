//
//  addAchivementViewController.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import UIKit
import SkyFloatingLabelTextField
import SideMenu
import FirebaseStorage
import Firebase
import SVProgressHUD
class addAchivementViewController: UIViewController ,NavigationWithImage, CustomNavigationAppearance,CustomMenuButtonItem,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var datatbaserefreence : DatabaseReference!
    var imagePicker : UIImagePickerController!
    var image : UIImage?
    var imageURL : String?
    @IBOutlet weak var uploadFile: SkyFloatingLabelTextField!
    @IBOutlet weak var orgName: SkyFloatingLabelTextField!
    @IBOutlet weak var voluntaryHours: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainNavigationAppearance()
        setupNavigationImageView()
        setupCustomMenuButton()
        setupText(Textfield: orgName)
        setupText(Textfield: voluntaryHours)
        setupText(Textfield: uploadFile)
        setupImage()
        setupFirebase()

    }
    
    @IBAction func uploadFileBtn(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a sourse", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default , handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                
                print("Camera is not available :) ")
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default , handler: { (action:UIAlertAction) in
            
             self.imagePicker.sourceType = .photoLibrary
            self.present( self.imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil ))
        self.present(actionSheet, animated: true, completion: nil )
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.image = image
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            self.uploadFile.text = imageURL.lastPathComponent
        }
        picker.dismiss(animated: true , completion: nil )
    }
 
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil )
     }
     
    func didPressMenuBtn() {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    @IBAction func showOpportunities(_ sender: Any) {
        
    }
    @IBAction func sentAchivement(_ sender: Any) {
        if Defaults.isUserLogedIn() {
            sendDataToFirebase()
        }
        else{
            let register = self.storyboard?.instantiateViewController(withIdentifier: "signUpViewController") as! signUpViewController
            self.navigationController?.pushViewController(register, animated: true)
        }
    }
    func setupText(Textfield: SkyFloatingLabelTextField){
        Textfield.delegate = self
        Textfield.isLTRLanguage = false
        Textfield.font = UIFont.textStyle14
        Textfield.titleFont = UIFont.textStyle14
        
    }

    func setupImage(){
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }
    func setupFirebase(){
        datatbaserefreence = Database.database().reference()
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
        orgName.resignFirstResponder()
        voluntaryHours.resignFirstResponder()
      
    }
    
    func sendDataToFirebase(){
       
     guard let orgName = orgName.text,
           let voluntaryHours = voluntaryHours.text
           else {
        Utilities().showErrorAlert(self, message: "جميع الحقول مطلوبة !")
            return
        }
        if !voluntaryHours.isNumeric {
            Utilities().showErrorAlert(self, message: "فضلا أدخل عدد الساعات فقط")
        }
        else{
        SVProgressHUD.show()
        let uid = Auth.auth().currentUser?.uid
        let name = Auth.auth().currentUser?.displayName
        let email = Auth.auth().currentUser?.email ?? ""
        let voluntaryHoursInt = Int(voluntaryHours) ?? 0
            print(voluntaryHoursInt)
        self.uploading() { uploaded in
            if uploaded == true {
                let url = self.imageURL ?? ""
                let value = ["email":email,"userID":uid ?? "","userName":name ?? "","certificateFile":url,"voluntaryHours":voluntaryHours,"organizationName":orgName,"points":"\(voluntaryHoursInt*10)","approved":0] as [String : Any]
                self.achivmentUploading(values: value)
            }
        }
    }
    }
    
    func uploadImage(_ image : UIImage , completion : @escaping ((_ urls:String?)->()))  {
        SVProgressHUD.show()

        //let userId = Auth.auth().currentUser?.uid
        let imageName = "image-\(NSUUID())-\(NSUUID())"
        let storageRefrence = Storage.storage().reference().child("achievementCertificate/\(imageName)")
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            storageRefrence.putData(imageData, metadata: metaData) { (metaData, error) in
                SVProgressHUD.dismiss()
                if error == nil && metaData != nil {
                    storageRefrence.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            return
                        }
                      completion(downloadURL.absoluteString)
                    }
                }else { completion(nil) }
        }
        }
    
    
     func uploading(completion : @escaping ((_ uploaded:Bool?)->()))  {
        
        if let img = self.image{
            self.uploadImage(img) { url in
                self.imageURL = url
                completion(true)
            }
        }
        else{
            completion(false)
        }
     }

    func achivmentUploading(values: [String:Any]) {
        SVProgressHUD.show()
        let achievementId = "achievementID\(NSUUID())"
        let achievementRefrence = self.datatbaserefreence.child("achievements").child("\(achievementId)")
        achievementRefrence.updateChildValues(values, withCompletionBlock: {(error, refrence) in
            if error != nil {
                print(error!)
            } else {
                SVProgressHUD.dismiss()
                let uid = Auth.auth().currentUser?.uid ?? ""
                let userDatabaserefrence = self.datatbaserefreence.child("users").child(uid).child("achievements")
                userDatabaserefrence.updateChildValues(values , withCompletionBlock : {(error , reference) in
                             if error != nil {
                                 print(error)
                             }
                             else{
                                Utilities().showSuccessAlert(self, message: "تم إرسال طلب إضافة انجازك بنجاح")
                             }
                         })
            }})
    }
}
