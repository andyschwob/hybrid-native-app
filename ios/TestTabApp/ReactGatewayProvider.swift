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

class ReactGatewayProvider: NSObject, RCTBridgeDelegate {
    
    static let defaultProvider = ReactGatewayProvider()
    
    weak var delegate: ReactGatewayProviderDelegate? {
        didSet {
            delegate != nil ? addEventObservers() : removeEventObservers()
        }
    }
    
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
    
    deinit {
        self.removeEventObservers()
    }
    
    func addEventObservers() {
        // Subscirbe to react events
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didReceiveApplicationExit),
                                               name: NSNotification.Name.ReactBridgeExitEvent,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didReceiveShowPost),
                                               name: NSNotification.Name.ReactBridgeShowPostEvent,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didReceiveDeepLink),
                                               name: NSNotification.Name.ReactBridgeDeepLinkEvent,
                                               object: nil)
        
    }
    
    func removeEventObservers() {
        // Remove self from notification center observers
        NotificationCenter.default.removeObserver(self)
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
    
    // ReactGateway delegate
    @objc func didReceiveApplicationExit(notification: Notification) {
        guard let data = notification.userInfo else { return }
        
        if let sender = data["component"] as? String {
            let event = ExitEvent.init(component: sender)
            delegate?.didReceiveExitEvent(event: event)
        }
    }
    
    @objc func didReceiveDeepLink(notification: Notification) {
        guard let data = notification.userInfo else { return }
        
        if let sender = data["component"] as? String, let destination = data["link"] as? String {
            if let url = URL.init(string: destination) {
                let event = DeepLinkEvent.init(destinationURL: url, component: sender)
                delegate?.didReceiveDeepLinkEvent(event: event)
            }
        }
    }
    
    @objc func didReceiveShowPost(notification: Notification) {
        guard let eventData = notification.userInfo else { return }
        
        let event = ShowPostEvent.init(eventData: eventData)
        if event.isValidEvent() {
            delegate?.didReceiveShowPostEvent(event: event)
        } else {
            print("EngagementSDK: malformed show post event received.")
        }
    }
    
    func sendProfileAttributes(attributes: Dictionary<AnyHashable, Any>) {
        NotificationCenter.default.post(name: Notification.Name.ReactBridgeNativeEvent, object: nil, userInfo: attributes)
    }
    
}



