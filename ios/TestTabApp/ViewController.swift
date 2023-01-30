//
//  ViewController.swift
//  TestTabApp
//
//  Created by Branding Brand on 1/24/23.
//

import UIKit
class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOne = TabOne()
        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        tabOne.tabBarItem = tabOneBarItem
        
        // Create Tab two
        let tabTwo = TabTwo()
        let tabTwoBarItem = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        tabTwo.tabBarItem = tabTwoBarItem
        self.viewControllers = [tabOne, tabTwo]
        
        let reactTab = ReactNativeVC()
        let reactBarItem = UITabBarItem(title: "RN Tab", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        reactTab.tabBarItem = reactBarItem
        self.viewControllers = [tabOne, tabTwo, reactTab]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}

