//
//  BridgeModule.m
//  TestTabApp
//
//  Created by Branding Brand on 2/1/23.
//

#import "BridgeModule.h"
#import "BridgeModuleConstants.h"

@implementation BridgeModule

RCT_EXPORT_MODULE(BridgeModule);

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}


RCT_EXPORT_METHOD(dispatchExitEvent:(NSDictionary *)data)
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ReactBridgeExitEvent
                                                        object:nil
                                                      userInfo:data];
    
}

RCT_EXPORT_METHOD(dispatchDeepLinkEvent:(NSDictionary *)data)
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ReactBridgeDeepLinkEvent
                                                        object:nil
                                                      userInfo:data];
    
}

RCT_EXPORT_METHOD(dispatchShowPostEvent:(NSDictionary *)data)
{

    [[NSNotificationCenter defaultCenter] postNotificationName:ReactBridgeShowPostEvent
                                                        object:nil
                                                      userInfo:data];
    
}

@end
    
