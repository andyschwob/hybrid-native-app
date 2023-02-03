//
//  BridgeModuleEvent.m
//  TestTabApp
//
//  Created by Branding Brand on 2/1/23.
//

#import "BridgeModuleEvent.h"

@implementation BridgeModuleEvent

- (instancetype)initWithData:(NSDictionary *)data
{
    if (self) {
        NSString *event = [data valueForKey:@"event"];
        if([event isEqual: @"EXIT"] || event.length < 1) {
            _eventType = 0;
        }
        else if ([event isEqual: @"ACTION"]) {
            _eventType = 1;
        }
        else if ([event isEqual: @"LINK"]) {
            _eventType = 2;
        }
        _invokingApplication = [data valueForKey:@"application"];
        _data = [data valueForKey:@"data"];
    }
    return self;
}

+ (NSDictionary *)typeDisplayName
{
    return @{@(kExit) : @"Exit",
             @(kAction) : @"Action",
             @(kLink) : @"Link"};
}

- (NSString *)typeDescrition
{
    return [[self class] typeDisplayName][@(self.eventType)];
}


@end
