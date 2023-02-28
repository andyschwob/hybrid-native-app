//
//  ShowPostProps.swift
//  TestTabApp
//
//  Created by Branding Brand on 2/27/23.
//

import Foundation
import UIKit

class ShowPostProps {
    let id: String?
    let name: String?
    let json: String?
    let discoverPath: String?
    let backButton: Bool?
    let isLoading: Bool?
    let dynamicData: [AnyHashable: Any]?
    let invokingComponent: String?
    
    @objc init(data: Dictionary<AnyHashable, Any>) {
        self.id = data["postId"] as? String
        self.name = data["postId"] as? String
        self.json = data["postId"] as? String
        self.discoverPath = data["postId"] as? String
        self.backButton = data["postId"] as? Bool ?? false
        self.isLoading = data["isLoading"] as? Bool ?? false
        self.dynamicData = data["postId"] as? [AnyHashable: Any]
        self.invokingComponent = data["postId"] as? String
    }
}
