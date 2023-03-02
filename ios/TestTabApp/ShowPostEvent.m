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
        NSString *component = [data objectForKey:@"component"];
        NSDictionary *props = [data objectForKey:@"data"];
        _props = [[ShowPostProps alloc] initWithComponentName:component data:props];
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
