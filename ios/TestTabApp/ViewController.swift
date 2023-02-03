//
//  ViewController.swift
//  TestTabApp
//
//  Created by Branding Brand on 1/24/23.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate, ReactGatewayProviderDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOne = TabOne()
        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = TabTwo()
        let tabTwoBarItem = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        tabTwo.tabBarItem = tabTwoBarItem
        self.viewControllers = [tabOne, tabTwo]
        
        let jsBundle = URL.init(string: "http://localhost:8081/index.bundle?platform=ios")!
        let moduleName = "ComponentOne"
        let initialProps = ["foo": "bar"]
        
        let reactGatewayProvider = ReactGatewayProvider.defaultProvider
        reactGatewayProvider.delegate = self
        let reactTab = reactGatewayProvider.newReactGatway(jsBundle: jsBundle,
                                                           moduleName: moduleName,
                                                           initialProps: initialProps)
        
        let reactBarItem = UITabBarItem(title: "RN Tab", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        reactTab.tabBarItem = reactBarItem
        self.viewControllers = [tabOne, tabTwo, reactTab]
    }
    
    //MARK: React Gateway Delegate
    func didReceiveReactApplicationEvent(event: BridgeModuleEvent) {
        print("EVENT RECEIVED: \(event.typeDescrition())")
        
        switch (event.eventType) {
        case .exit:
            print("Exit")
        case .link:
            print("Link")
        case .action:
            print("Action")
        default:
            return
        }

        print("\(event.invokingComponent)")
        print("\(event.data)")
    }

    //MARK: Tab Bar delegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    
    }
}

