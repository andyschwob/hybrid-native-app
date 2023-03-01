//
//  ReactEventEmitter.h
//  TestTabApp
//
//  Created by Branding Brand on 2/20/23.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

NS_ASSUME_NONNULL_BEGIN

@interface BridgeModuleEventEmitter : RCTEventEmitter <RCTBridgeModule>

- (void)dispatchEvent:(NSDictionary *)profileAttributes;

@end

NS_ASSUME_NONNULL_END
