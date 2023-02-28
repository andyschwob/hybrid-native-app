//
//  ShowPostProps.m
//  TestTabApp
//
//  Created by Branding Brand on 2/28/23.
//

#import "ShowPostProps.h"

@implementation ShowPostProps

- (instancetype)initWithDataDictionary:(NSDictionary *)dataDictionary
{
    self = [self init];
    if (self) {
        _postId = [dataDictionary objectForKey:@"postId"];
        _json = [dataDictionary objectForKey:@"json"];
        _name = [dataDictionary objectForKey:@"name"];
        _dynamicData = [dataDictionary objectForKey:@"dynamicData"];
        _invokingComponent = [dataDictionary objectForKey:@"component"];
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
        @"dynamicData": self.dynamicData,
        @"isLoading": @NO
    };
}
@end
