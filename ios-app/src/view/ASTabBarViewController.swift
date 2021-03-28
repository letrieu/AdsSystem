//
//  ASTabBarViewController.swift
//  ios-app
//
//  Created by TrieuLD on 28/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import UIKit
import MultiPlatformLibrary
import MultiPlatformLibraryMvvm

class ASTabBarViewController: UITabBarController {
    
    private var viewModel: TabbarViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = buildNavigationController(for: HomeViewController())
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: homeVC.title, image: UIImage(named: "home"), selectedImage: nil)
        let hotVC = buildNavigationController(for: UIViewController())
        hotVC.title = "Hot"
        hotVC.tabBarItem = UITabBarItem(title: hotVC.title, image: UIImage(named: "fire"), selectedImage: nil)
        let shopVC =  buildNavigationController(for: UIViewController())
        shopVC.title = "Shop"
        shopVC.tabBarItem = UITabBarItem(title: shopVC.title, image: UIImage(named: "store-alt"), selectedImage: nil)
        let nearVC = buildNavigationController(for: UIViewController())
        nearVC.title = "Near"
        nearVC.tabBarItem = UITabBarItem(title: nearVC.title, image: UIImage(named: "location-arrow"), selectedImage: nil)
        let notifVC = buildNavigationController(for: UIViewController())
        notifVC.title = "Notification"
        notifVC.tabBarItem = UITabBarItem(title: notifVC.title, image: UIImage(named: "bell"), selectedImage: nil)

        self.viewControllers = [homeVC, hotVC, shopVC, nearVC, notifVC]
    }
    
    func buildNavigationController(for vc: UIViewController) -> TLNavigationController {
        return TLNavigationController(rootViewController: vc)
    }
}

extension ASTabBarViewController: TabbarViewModelEventsListener {
    
    func routeToHomeTab() {
        self.selectedIndex = 0
    }
    
    func routeToHotTab() {
        self.selectedIndex = 1
    }
    
    func routeToShopTab() {
        self.selectedIndex = 2
    }
    
    func routeToNearTab() {
        self.selectedIndex = 3
    }
    
    func routeToNotificationTab() {
        self.selectedIndex = 4
    }
}
