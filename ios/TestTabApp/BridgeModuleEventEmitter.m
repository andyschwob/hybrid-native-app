//
//  ReactEventEmitter.m
//  TestTabApp
//
//  Created by Branding Brand on 2/20/23.
//

#import "BridgeModuleEventEmitter.h"
#import "BridgeModuleConstants.h"

@implementation BridgeModuleEventEmitter

RCT_EXPORT_MODULE(BridgeModuleEventEmitter);
RCT_EXTERN_METHOD(supportedEvents);

-(void)startObserving
{
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(dispatchEvent:)
                                               name:ReactBridgeNativeEvent
                                             object:nil];
}

-(void)stopObserving
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onUpdateProfileAttributes"];
}

- (void)dispatchEvent:(NSNotification *)notification
{
    if (notification.userInfo != nil) {
        NSDictionary *profileAttributes = notification.userInfo;
        [self sendEventWithName:@"onUpdateProfileAttributes" body:profileAttributes];
    }
}

@end
