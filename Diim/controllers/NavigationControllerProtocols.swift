//
//  NavigationControllerProtocols.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import Foundation
import UIKit
protocol CustomNavigationAppearance {}
protocol CustomNavigationAppearanceClear {}

extension CustomNavigationAppearance where Self: UIViewController {
  func setupMainAppearance(backGroundColor: UIColor = .white,
                           tintColor: UIColor = UIColor.aquaBlue) {
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.tintColor = tintColor
    navigationController?.navigationBar.barTintColor = backGroundColor
    navigationController?.navigationBar.backgroundColor = backGroundColor
    let font = UIFont.textStyle14
    navigationController?.navigationBar.titleTextAttributes = [.font: font]
    navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController!.navigationBar.shadowImage = UIImage()
      let backButton = UIBarButtonItem()
      backButton.title = ""
      self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
  }
}
extension CustomNavigationAppearanceClear where Self: UIViewController {
    func setupMainAppearancec(backGroundColor: UIColor = .clear,
                           tintColor: UIColor = UIColor.white) {

    let font = UIFont.textStyle14
    navigationController?.navigationBar.titleTextAttributes = [.font: font]
    navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = tintColor
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor =  UIColor.clear
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
      let backButton = UIBarButtonItem()
      backButton.title = ""
      self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let image = #imageLiteral(resourceName: "logoWhite")
        setupNavigationImageView(image)
  }
    func setupNavigationImageView(_ image: UIImage = #imageLiteral(resourceName: "logo")) {
      guard let navController = navigationController else { return }
      let bannerHeight = navController.navigationBar.frame.size.height
      let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 108, height: 30))
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 108, height: bannerHeight - 12))
      imageView.image = image
      imageView.contentMode = .scaleAspectFit
      logoContainer.addSubview(imageView)
      navigationItem.titleView = logoContainer
    }
}
@objc protocol CustomMenuButtonItem {
  @objc func didPressMenuBtn()
}

extension CustomMenuButtonItem where Self: UIViewController {
  func setupCustomMenuButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: #imageLiteral(resourceName: "iosMenu"),
      style: .plain,
      target: self,
      action: #selector(didPressMenuBtn)
    )
  }
}


protocol NavigationWithImage: CustomNavigationAppearance {}
extension NavigationWithImage where Self: UIViewController {
    func setupMainNavigationAppearance(_ image: UIImage = #imageLiteral(resourceName: "logo"),
                                     backGroundColor: UIColor = .white,
                                     tintColor: UIColor = UIColor.aquaBlue) {
    setupMainAppearance(backGroundColor: backGroundColor, tintColor: tintColor)
    setupNavigationImageView(image)
  }

  func setupNavigationImageView(_ image: UIImage = #imageLiteral(resourceName: "logo")) {
    guard let navController = navigationController else { return }
    let bannerHeight = navController.navigationBar.frame.size.height
    let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 108, height: 30))
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 108, height: bannerHeight - 12))
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    logoContainer.addSubview(imageView)
    navigationItem.titleView = logoContainer
  }
}
