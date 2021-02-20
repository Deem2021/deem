//
//  pointsViewController.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import UIKit
import SideMenu
import Firebase
import SVProgressHUD
class pointsViewController: UIViewController , CustomNavigationAppearanceClear,CustomMenuButtonItem,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var numberOfPoints: UILabel!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    var databaseRefrence: DatabaseReference!
    var courses = [Course]()
    var Consultations = [Consultation]()
    var Coupons = [Coupon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainAppearancec()
        setupCustomMenuButton()
        getDataFromFirebase()
    }
    override func viewWillAppear(_ animated: Bool) {
        getDataFromFirebase()

    }
    func didPressMenuBtn() {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    func getDataFromFirebase(){
        SVProgressHUD.show()
        databaseRefrence = Database.database().reference()
        databaseRefrence.child("services").observe(.value) { (snapshots:DataSnapshot) in
            SVProgressHUD.dismiss()
            guard let value = snapshots.value as? [String: Any] else { return }
                 do {
                     let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                     let ServicesData = try JSONDecoder().decode(Services.self, from: jsonData)
                    
                    self.Consultations = ServicesData.consultations
                    self.courses = ServicesData.courses
                    self.Coupons = ServicesData.coupons
                    self.collectionView1.reloadData()
                    self.collectionView2.reloadData()
                    self.collectionView3.reloadData()

                 } catch let error {
                     print(error)
                 }
        }
        
        let uID = Auth.auth().currentUser?.uid
        self.databaseRefrence.child("users").child(uID!).child("achievements").observe(.value) { (snapshot) in
            SVProgressHUD.dismiss()
                 if let dectionary = snapshot.value as? [String:AnyObject] {
                 let points = dectionary["points"] as? String
                    self.points.text = "\(points ?? "0") نقاط"
                 
             }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView1{
            return courses.count
        }
        else{
            if collectionView == self.collectionView2{
                return Consultations.count
            }
            else{
                if collectionView == self.collectionView3{
                    return Coupons.count
                }
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.collectionView1{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "coursesCollectionViewCell", for: indexPath) as! coursesCollectionViewCell
            cell1.img.image = #imageLiteral(resourceName: "onlineEducation")
            cell1.name.text = courses[indexPath.row].name
            cell1.point.text = "\(courses[indexPath.row].points)نقاط"
            cell1.type.text = courses[indexPath.row].verified ? "معتمدة" : "غير معتمدة"
            return cell1
        }
        else{
        if collectionView == self.collectionView2{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "consultationCollectionViewCell", for: indexPath) as! consultationCollectionViewCell
            cell1.img.image = #imageLiteral(resourceName: "podcast-1")
            cell1.name.text = Consultations[indexPath.row].name
            cell1.point.text = "\(Consultations[indexPath.row].points)نقاط"
            cell1.type.text = "\(Consultations[indexPath.row].type)"
            return cell1
        }
        else{
        if collectionView == self.collectionView3{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "couponCollectionViewCell", for: indexPath) as! couponCollectionViewCell
            cell1.img.image = #imageLiteral(resourceName: "discount")
            cell1.name.text = Coupons[indexPath.row].name
            cell1.point.text = "\(Coupons[indexPath.row].points)نقاط"
            cell1.type.text = "\(Coupons[indexPath.row].percentage)"
            
            return cell1
        }
        else{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "couponCollectionViewCell", for: indexPath) as! couponCollectionViewCell
            return cell1
        }
        }
        }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView1{
            let replacePoint = self.storyboard?.instantiateViewController(withIdentifier: "replacePointsViewController") as! replacePointsViewController
            replacePoint.points = courses[indexPath.row].points
            self.present(replacePoint, animated: true, completion: nil)
            
        }
        else{
        if collectionView == self.collectionView2{
            let replacePoint = self.storyboard?.instantiateViewController(withIdentifier: "replacePointsViewController") as! replacePointsViewController
            replacePoint.points = Consultations[indexPath.row].points
            self.present(replacePoint, animated: true, completion: nil)
           
        }
        else{
        if collectionView == self.collectionView3{
            let replacePoint = self.storyboard?.instantiateViewController(withIdentifier: "replacePointsViewController") as! replacePointsViewController
            replacePoint.points = Coupons[indexPath.row].points
            self.present(replacePoint, animated: true, completion: nil)
        }

        }
        }
    }
    
}
