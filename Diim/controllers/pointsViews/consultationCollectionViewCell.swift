//
//  podcastCollectionViewCell.swift
//  Diim
//
//  Created by Diim on 19/02/2021.
//

import UIKit

class consultationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var replacePoints: UIButton!
    @IBAction func replacePoint(_ sender: Any) {
    }
    override func layoutSubviews() {
        cellStyle()
    }
   func cellStyle(){
   self.layer.cornerRadius = 10
     self.layer.masksToBounds = true
   // replacePoints.layer.cornerRadius = 5
   // replacePoints.layer.masksToBounds = true
   // replacePoints.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]

     // cell shadow section
     self.contentView.layer.cornerRadius = 10
     self.contentView.layer.borderWidth = 0
     self.contentView.layer.borderColor = UIColor.clear.cgColor
     self.contentView.layer.masksToBounds = true
     self.layer.shadowColor = UIColor.lightGray.cgColor
     self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
     self.layer.shadowRadius = 10
     self.layer.shadowOpacity = 0.3
     self.layer.masksToBounds = false
     self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
    }
}
