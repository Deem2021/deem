//
//  replacePointsViewController.swift
//  Diim
//
//  Created by Diim on 20/02/2021.
//

import UIKit
import Firebase
import SVProgressHUD
class replacePointsViewController: UIViewController {

    var points = 0
    var databaseRefrence: DatabaseReference!
    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.applyShadowView3()
        print(points)
    }
    
    @IBAction func replacePoints(_ sender: Any) {
        databaseRefrence = Database.database().reference()
        let uID = Auth.auth().currentUser?.uid
        databaseRefrence.child("users").child(uID!).child("achievements").child("points").runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            let voteCount = currentData.value as? String
            let count = Int(voteCount ?? "0")!
            if self.points < count {
            print(count)
            print(count-self.points)
                currentData.value = "\(count-self.points)"
                Utilities().showSuccessAlert(self, message: "لقد تم استبدال نقاطك يمكنك ايجاد المكافأة في صفحتك الشخصية")
                return TransactionResult.success(withValue: currentData)
            }
            else{
                Utilities().showErrorAlert(self, message: "عذرا لاتملك نقاط كافية")
                return TransactionResult.abort()
            }
            })
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 

}
