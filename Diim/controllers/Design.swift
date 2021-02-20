//
//  ViewController.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import UIKit
import Foundation
class Design{
    

    static func buttonShadowAndBorder(button: UIButton,border: Bool,shadow: Bool){
        if shadow{
            button.layer.masksToBounds = false
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            button.layer.shadowOpacity = 0.3
            button.layer.shadowRadius = 1.0
        }
        if border{
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.melon.cgColor
        }
    }
    
    static func customView(view: UIView){
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 12
    }
    
    //MARK: Custmize UIView by adding border
    static func viewCustomizationBorder(view :UIView){
        let myCustomRGBColor = UIColor(red: 2.0/255.0, green: 178.0/255.0, blue: 212.0/255.0, alpha: 1.0)
        view.layer.borderColor = myCustomRGBColor.cgColor
        view.layer.borderWidth = 1
    }
    
    
    static func viewShadow(view: UIView){
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: view.frame.size.width + shadowSize,
                                                   height: view.frame.size.height + shadowSize))
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowPath = shadowPath.cgPath
        view.layer.shadowRadius = 12
        view.layer.cornerRadius = 12
    }
    
}

