//
//  BBReactNativeViewController.h
//  TestTabApp
//
//  Created by Branding Brand on 1/31/23.
//

#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>

NS_ASSUME_NONNULL_BEGIN

@class ReactGateway;

@interface ReactGateway : UIViewController

- (instancetype)initWithBridge:(RCTBridge *)bridge
                      moduleName:(NSString *)name
                  initialProps:(nullable NSDictionary *)props;

@end

NS_ASSUME_NONNULL_END
