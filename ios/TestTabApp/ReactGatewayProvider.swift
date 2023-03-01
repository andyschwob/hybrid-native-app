//
//  ReactGatewayManager.swift
//  TestTabApp
//
//  Created by Branding Brand on 2/3/23.
//

import Foundation
import React

protocol ReactGatewayProviderDelegate : NSObjectProtocol {
    func didReceiveShowPostEvent(event: ShowPostEvent)
    func didReceiveExitEvent(event: ExitEvent)
    func didReceiveDeepLinkEvent(event: DeepLinkEvent)
}

class ReactGatewayProvider: NSObject, RCTBridgeDelegate, BridgeModuleProtocol {
    
    @objc static let defaultProvider = ReactGatewayProvider()
    
    weak var delegate: ReactGatewayProviderDelegate?
    @objc weak var bridgeModule: BridgeModule? {
        didSet {
            if (bridgeModule != nil) {
                bridgeModule?.delegate = self
            }
        }
    }
    
    @objc var eventEmitter: BridgeModuleEventEmitter?
    private var gateways: [ReactGateway] = []
    private var appId: String = ""
    private var bridgeHolder: RCTBridge?
    
    
    //MARK: Lifecycle
    private override init() {
        // Get app id from plist
        guard let plistPath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            return
        }
        
        let contents  = try? NSDictionary.init(contentsOf: URL.init(fileURLWithPath: plistPath), error: ())
        
        if let appId = contents?.value(forKey: "BBEngagementAppID") as? String {
            self.appId = appId
        }
        else {
            print("EngagementSDK: Could not retreive application id from .plist")
        }
        
    }
    
    //MARK: React Native host View Controller
    func getFeedViewController(accountId: String?, profileAttributes: Dictionary<AnyHashable, Any>?) -> ReactGateway {
        var props = profileAttributes ?? Dictionary<AnyHashable, Any>.init()
        if (accountId != nil) {
            let appenededDict = NSMutableDictionary.init(dictionary: props)
            appenededDict.setValue(accountId, forKey: "accountId")
            props = appenededDict as Dictionary
        }
        return ReactGateway.init(bridge: self.currentBridge(), moduleName: "ComponentOne", initialProps: props)
    }
    
    //TODO: Refactor bunlde location and get expected keys for values in engagement componenet
    func getPostViewController(showPostProps: ShowPostProps) -> ReactGateway {
        let props: Dictionary<AnyHashable, Any> = showPostProps.getJSObjectRepresenation()
        return ReactGateway.init(bridge: self.currentBridge(), moduleName: "ComponentOne", initialProps: props)
    }
    
    //MARK: React bridge delegate
    func currentBridge() -> RCTBridge {
        if let bridge = bridgeHolder {
            return bridge
        }
        else {
            // Possibly failable
            bridgeHolder = RCTBridge.init(delegate: self, launchOptions: nil)
            return bridgeHolder!
        }
    }
    
    func sourceURL(for bridge: RCTBridge!) -> URL! {
        return URL.init(string: "http://localhost:8081/index.bundle?platform=ios")!
    }
    
    //MARK: BridgeModuleDelegate
    
    func didReceiveExitEvent(_ eventData: [AnyHashable : Any]) {
        if let sender = eventData["component"] as? String {
            let event = ExitEvent.init(component: sender)
            delegate?.didReceiveExitEvent(event: event)
        }
        else {
            
        }
    }
    
    func didReceiveShowPostEvent(_ eventData: [AnyHashable : Any]) {
        let event = ShowPostEvent.init(eventData: eventData)
        if event.isValidEvent() {
            delegate?.didReceiveShowPostEvent(event: event)
        } else {
            print("EngagementSDK: malformed show post event received.")
        }
    }
    
    func didReceiveDeepLinkEvent(_ eventData: [AnyHashable : Any]) {
        if let sender = eventData["component"] as? String,
           let destination = eventData["link"] as? String {
            if let url = URL.init(string: destination) {
                let event = DeepLinkEvent.init(destinationURL: url, component: sender)
                delegate?.didReceiveDeepLinkEvent(event: event)
            }
        }
    }
    
    //MARK: RN event emitter
    func sendProfileAttributes(attributes: Dictionary<AnyHashable, Any>) {
        eventEmitter?.dispatchEvent(attributes)
    }
    
}



