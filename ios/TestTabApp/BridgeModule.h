//
//  BridgeModule.h
//  TestTabApp
//
//  Created by Branding Brand on 2/1/23.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import "ExitEvent.h"
#import "DeepLinkEvent.h"
#import "ShowPostEvent.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BridgeModuleProtocol <NSObject>

- (void)didReceiveExitEvent:(NSDictionary *)eventData;
- (void)didReceiveShowPostEvent:(NSDictionary *)eventData;
- (void)didReceiveDeepLinkEvent:(NSDictionary *)eventData;

@end

@interface BridgeModule : NSObject <RCTBridgeModule>

@property (nonatomic, weak) id <BridgeModuleProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
