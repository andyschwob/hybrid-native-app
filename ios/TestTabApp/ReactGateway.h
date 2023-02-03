//
//  BBReactNativeViewController.h
//  TestTabApp
//
//  Created by Branding Brand on 1/31/23.
//

#import <UIKit/UIKit.h>
#import "BridgeModuleEvent.h"

NS_ASSUME_NONNULL_BEGIN

@class ReactGateway;
@protocol ReactGatewayDelegate <NSObject>

- (void)didReceiveReactApplicationEvent:(BridgeModuleEvent *)event;

@end

@interface ReactGateway : UIViewController

@property (nonatomic, weak) id <ReactGatewayDelegate> delegate;

- (instancetype)initWithJsBundle:(NSURL*)bundle
                      moduleName:(NSString *)name
                    initialProps:(nullable NSDictionary *)props;

@end

NS_ASSUME_NONNULL_END
