//
//  TabTwo.swift
//  TestTabApp
//
//  Created by Branding Brand on 1/24/23.
//

import Foundation
import UIKit

class TabTwo: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let label = UILabel.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: self.view.frame.height/2 - 35), size: CGSize.init(width: self.view.frame.width, height: 70)))
        label.text = "View Controller Two"
        label.textAlignment = .center
        self.view.addSubview(label)
        
    }
}
