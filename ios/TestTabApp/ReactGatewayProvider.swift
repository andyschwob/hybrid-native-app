//
//  ReactGatewayManager.swift
//  TestTabApp
//
//  Created by Branding Brand on 2/3/23.
//

import Foundation

protocol ReactGatewayProviderDelegate : NSObjectProtocol {
    func didReceiveReactApplicationEvent(event: BridgeModuleEvent)
}

class ReactGatewayProvider {

    static let defaultProvider = ReactGatewayProvider()
    weak var delegate: ReactGatewayProviderDelegate?
    private var gateways: [ReactGateway] = []

    //MARK: Lifecycle
    private init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didReceiveMessage),
                                               name: NSNotification.Name.ReactBridgeEventIdentifier,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: React Native host View Controller
    func newReactGatway(jsBundle: URL,
                        moduleName: String,
                        initialProps: Dictionary<AnyHashable, Any>) -> ReactGateway {
        
        let reactTab = ReactGateway.init(jsBundle: jsBundle,
                                         moduleName: moduleName,
                                         initialProps: initialProps);
        return reactTab
    }
    
    // ReactGateway delegate
    @objc func didReceiveMessage(notification: Notification) {
        if let data = notification.userInfo {
            let event = BridgeModuleEvent.init(data: data)
            delegate?.didReceiveReactApplicationEvent(event: event)
        }
    }
}



