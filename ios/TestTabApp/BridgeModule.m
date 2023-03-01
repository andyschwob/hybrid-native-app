//
//  BridgeModule.m
//  TestTabApp
//
//  Created by Branding Brand on 2/1/23.
//

#import "BridgeModule.h"
#import "TestTabApp-Swift.h"

@implementation BridgeModule

RCT_EXPORT_MODULE(BridgeModule);

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

- (instancetype)init {
    self = [super self];
    if (self) {
        [ReactGatewayProvider defaultProvider].bridgeModule = self;
    }
    return self;
}


RCT_EXPORT_METHOD(dispatchExitEvent:(NSDictionary *)data)
{
    [self.delegate didReceiveExitEvent:data];
}

RCT_EXPORT_METHOD(dispatchDeepLinkEvent:(NSDictionary *)data)
{
    [self.delegate didReceiveDeepLinkEvent:data];
}

RCT_EXPORT_METHOD(dispatchShowPostEvent:(NSDictionary *)data)
{
    [self.delegate didReceiveShowPostEvent:data];
}

@end

