//
//  ShowPostProps.m
//  TestTabApp
//
//  Created by Branding Brand on 2/28/23.
//

#import "ShowPostProps.h"

@implementation ShowPostProps

- (instancetype)initWithComponentName:(NSString *)name data:(NSDictionary *)eventData
{
    self = [self init];
    if (self) {
        _postId = [eventData objectForKey:@"postId"];
        _json = [eventData objectForKey:@"json"];
        _name = [eventData objectForKey:@"name"];
        _dynamicData = [eventData objectForKey:@"dynamicData"];
        _invokingComponent = name;
    }
    return self;
}

- (BOOL)areValidProps
{
    if (self.postId != nil &&
        self.json != nil &&
        self.name != nil &&
        self.invokingComponent != nil) {
        return true;
    }
    else {
        return false;
    }
}

- (NSDictionary *)getJSObjectRepresenation
{
    return @{
        @"id": self.postId,
        @"name": self.name,
        @"json": self.json,
//        @"dynamicData": self.dynamicData,
        @"isLoading": @NO
    };
}
@end
