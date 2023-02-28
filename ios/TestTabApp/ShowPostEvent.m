//
//  ShowPostEvent.m
//  TestTabApp
//
//  Created by Branding Brand on 2/20/23.
//

#import "ShowPostEvent.h"

@implementation ShowPostEvent

- (instancetype)initWithEventData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _props = [[ShowPostProps alloc] initWithDataDictionary:data];
    }
    return self;
}

- (BOOL)isValidEvent
{
    if (self.props != nil && [self.props areValidProps]) {
        return true;
    }
    else {
        return false;
    }
}

@end
