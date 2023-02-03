//
//  ReactNativeVC.swift
//  TestTabApp
//
//  Created by Branding Brand on 1/26/23.
//

import UIKit
import React

protocol BBBridgeDelegateProtcol {
    func didStartReactAppWithResponse(data: String)
}

class ReactNativeVC: UIViewController {
    var delegate: BBBridgeDelegateProtcol? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")!
        let rootView = RCTRootView.init(bundleURL: jsCodeLocation,
                                        moduleName: "HybridNativeApp",
                                        initialProperties: nil,
                                        launchOptions: nil);
        self.view = rootView
    }
    
}
