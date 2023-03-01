//
//  ReactEventEmitter.m
//  TestTabApp
//
//  Created by Branding Brand on 2/20/23.
//

#import "BridgeModuleEventEmitter.h"
#import "TestTabApp-Swift.h"

@implementation BridgeModuleEventEmitter

RCT_EXPORT_MODULE(BridgeModuleEventEmitter);
RCT_EXTERN_METHOD(supportedEvents);

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [ReactGatewayProvider defaultProvider].eventEmitter = self;
    }
    return self;
}


- (NSArray<NSString *> *)supportedEvents {
    return @[@"onUpdateProfileAttributes"];
}

- (void)dispatchEvent:(NSDictionary *)profileAttributes
{
    if (profileAttributes != nil) {
        [self sendEventWithName:@"onUpdateProfileAttributes" body:profileAttributes];
    }
    else {
        NSLog(@"Enganement SDK: Malformed profile attributes event received");
    }
}

@end
