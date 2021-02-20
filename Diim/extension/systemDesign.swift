//
//  color.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import Foundation
import UIKit

extension UIColor {
  @nonobjc class var melon: UIColor {
    return UIColor(red: 1.0, green: 133.0 / 255.0, blue: 82.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var aquaBlue: UIColor {
    return UIColor(red: 0.0, green: 216.0 / 255.0, blue: 216.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var brownGrey: UIColor {
    return UIColor(white: 151.0 / 255.0, alpha: 1.0)
  }
}
extension UIFont {
  class var textStyle72: UIFont {
    return UIFont(name: "18KhebratMusamim", size: 72.0)!
  }
  class var textStyle18: UIFont {
    return UIFont(name: "18KhebratMusamim", size: 18.0)!
  }
  class var textStyle14: UIFont {
    return UIFont(name: "18KhebratMusamim", size: 14.0)!
  }
    class var textStyle24: UIFont {
        return UIFont(name: "18KhebratMusamim", size: 24.0)!
    }
    class var textStyle8: UIFont {
        return UIFont(name: "18KhebratMusamim", size: 8.0)!
    }
    class var textStyle10: UIFont {
        return UIFont(name: "18KhebratMusamim", size: 10.0)!
    }
}
 extension UIButton
{

  func alignTextBelow(spacing: CGFloat = 6.0)
  {
      if let image = self.imageView?.image
      {
          let imageSize: CGSize = image.size
          self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
          let labelString = NSString(string: self.titleLabel!.text!)
          let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font])
          self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
      }
  }
}
extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}

extension UIView {
    
    func applyGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x : 0.0, y : 0.5)
        gradient.endPoint = CGPoint(x :1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
    func applyShadowView() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.cornerRadius = 10
        self.clipsToBounds = false
        self.layer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 1
    }
    func applyShadowView1() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.cornerRadius = 10
        self.clipsToBounds = false
        self.layer.backgroundColor = #colorLiteral(red: 0, green: 0.8859769702, blue: 0.8778158426, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.8859769702, blue: 0.8778158426, alpha: 1)
        self.layer.borderWidth = 1
    }
    func applyShadowView2() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.clipsToBounds = false
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderWidth = 1
    }
    func applyShadowView3() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.cornerRadius = 10
        self.clipsToBounds = false
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderWidth = 1
    }
}
