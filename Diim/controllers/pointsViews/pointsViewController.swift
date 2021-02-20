//
//  pointsViewController.swift
//  Diim
//
//  Created by Fatima Aljaber on 18/02/2021.
//

import UIKit
import SideMenu

class pointsViewController: UIViewController , CustomNavigationAppearanceClear,CustomMenuButtonItem,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var numberOfPoints: UILabel!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainAppearancec()
        setupCustomMenuButton()
    }
    
    func didPressMenuBtn() {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "coursesCollectionViewCell", for: indexPath) as! coursesCollectionViewCell

        if collectionView == self.collectionView1{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "coursesCollectionViewCell", for: indexPath) as! coursesCollectionViewCell
            return cell1
        }
        else{
        if collectionView == self.collectionView2{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCollectionViewCell", for: indexPath) as! podcastCollectionViewCell
            return cell1
        }
        else{
        if collectionView == self.collectionView3{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "couponCollectionViewCell", for: indexPath) as! couponCollectionViewCell
            return cell1
        }
        }}
        return cell1

    }
    
}
