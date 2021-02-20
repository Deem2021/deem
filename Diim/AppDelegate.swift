//
//  AppDelegate.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import UIKit
import Firebase
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let userDefaults = UserDefaults.standard
        if (!userDefaults.bool(forKey: "onboardingComplete")){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = sb.instantiateViewController(withIdentifier: "ViewController1")
            window?.rootViewController = initialViewController
            window?.makeKeyAndVisible()
            print("Onboarding")
        }
        else{
        if userDefaults.bool(forKey: "onboardingComplete") {
            self.Main()
            print("onboardingComplete")
        }
        }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.textStyle10],for: .normal)
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func Main(){
//        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//       let mainPage = mainStoryboard.instantiateViewController(withIdentifier: "UITabBarController1") as! UITabBarController
//        self.window?.rootViewController = mainPage
//        if let tabBarController = self.window?.rootViewController as? UITabBarController {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier :"VoluntaryOpportunitiesViewController") as! VoluntaryOpportunitiesViewController
//            let vc =  UINavigationController(rootViewController: viewController)
//            vc.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.textStyle18,NSAttributedString.Key.foregroundColor: UIColor.white]
//            tabBarController.viewControllers?[2] = vc
//            tabBarController.tabBar.items?[2].title = ""
//
//        }
    
    }

}

