//
//  BBReactNativeViewController.h
//  TestTabApp
//
//  Created by Branding Brand on 1/31/23.
//

#import <UIKit/UIKit.h>
#import "ShowPostEvent.h"
#import "ExitEvent.h"
#import "DeepLinkEvent.h"

NS_ASSUME_NONNULL_BEGIN

@class ReactGateway;

@interface ReactGateway : UIViewController

- (instancetype)initWithJsBundle:(NSURL*)bundle
                      moduleName:(NSString *)name
                    initialProps:(nullable NSDictionary *)props;

@end

NS_ASSUME_NONNULL_END
