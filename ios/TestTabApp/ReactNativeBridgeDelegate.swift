//
//  ReactNativeBridgeDelegate.swift
//  TestTabApp
//
//  Created by Branding Brand on 1/31/23.
//

import Foundation

protocol ReactNativeBridgeProtocol: NSObject {
    func didStartReactApplication(data: String)
}
