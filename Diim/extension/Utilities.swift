//
//  Utilities.swift
//  Diim
//
//  Created by Diim on 19/02/2021.
//

import Foundation
import UIKit
import SCLAlertView

class Utilities {
    
func showErrorAlert(_ controller: UIViewController, message: String?) {
    guard message != nil else {
        print("showErrorAlert(): No message to display.")
        return
    }
    
    DispatchQueue.main.async {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont.textStyle18,
            kTextFont: UIFont.textStyle14,
            kButtonFont: UIFont.textStyle14,
            dynamicAnimatorActive: true
        )
        let alert = SCLAlertView(appearance:appearance)
        
        alert.showCustom("عذراً",subTitle:message!, color: UIColor.melon, icon: #imageLiteral(resourceName: "cancelwhite"),closeButtonTitle:"موافق")
    }
}
    func showSuccessAlert(_ controller: UIViewController, message: String?) {
        guard message != nil else {
            print("showErrorAlert():   No message to display.")
            return
        }
        DispatchQueue.main.async {
            let appearance = SCLAlertView.SCLAppearance(
                kTitleFont: UIFont.textStyle18,
                kTextFont: UIFont.textStyle14,
                kButtonFont: UIFont.textStyle14,
                dynamicAnimatorActive: true
            )
            let alert = SCLAlertView(appearance:appearance)
            
            alert.showCustom("تم",subTitle:message!, color: UIColor.melon, icon: #imageLiteral(resourceName: "check-mark-white"),closeButtonTitle:"موافق")
        }
    }
}
