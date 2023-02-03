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

RCT_EXPORT_METHOD(dispatchApplicationEvent:(NSDictionary *)data)
{
    [self dispatchResult:data];
}

- (void)dispatchResult:(NSDictionary *)data
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ReactBridgeEventIdentifier
                                                        object:nil
                                                      userInfo:data];
}

@end
    
