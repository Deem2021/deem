//
//  VoluntaryOpportunitiesViewController.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import UIKit
import youtube_ios_player_helper
import SideMenu

class VoluntaryOpportunitiesViewController: UIViewController,NavigationWithImage, CustomNavigationAppearance,CustomMenuButtonItem {
    @IBOutlet weak var playerVedio: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainNavigationAppearance()
        setupNavigationImageView()
        setupCustomMenuButton()
        playerVedio.load(withVideoId: "6jKyifBjzKg", playerVars: ["playsinline": "1"])
        playerVedio.delegate = self
    }
    
    @IBAction func didPressGoToWeb(_ sender: Any) {
        let urll =  NSURL(string:"https://nvg.gov.sa")!
        UIApplication.shared.openURL(urll as URL)
    }
    func didPressMenuBtn() {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    

}
extension VoluntaryOpportunitiesViewController: YTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return UIColor.black
    }
    
   
}
