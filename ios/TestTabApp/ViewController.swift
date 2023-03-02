//
//  ViewController.swift
//  TestTabApp
//
//  Created by Branding Brand on 1/24/23.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate, ReactGatewayProviderDelegate {
    
    let reactGatewayProvider = ReactGatewayProvider.defaultProvider
    
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
        
        reactGatewayProvider.delegate = self
        
        let reactTab = reactGatewayProvider.getFeedViewController(accountId: nil, profileAttributes: nil)
        
        let reactBarItem = UITabBarItem(title: "RN Tab", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        reactTab.tabBarItem = reactBarItem
        self.viewControllers = [tabOne, tabTwo, reactTab]
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) { [weak self] in
            print("invoked")
            let props = ["attributes" : ["foo" : "bar"]]
            self?.reactGatewayProvider.sendProfileAttributes(attributes: props)
        }
    }
    
    //MARK: React Gateway Delegate
    func didReceiveShowPostEvent(event: ShowPostEvent) {
        let showPostVC = reactGatewayProvider.getPostViewController(showPostProps: event.props)
        self.present(showPostVC, animated: true, completion: nil)
        print("Show post: \(event.props.postId)")
    }
    
    func didReceiveExitEvent(event: ExitEvent) {
        print("Should exit application: \(event.invokingComponent)")
    }
    
    func didReceiveDeepLinkEvent(event: DeepLinkEvent) {
        print("Open Deeplink: \(event.url)")
    }
    

    //MARK: Tab Bar delegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    
    }
}

