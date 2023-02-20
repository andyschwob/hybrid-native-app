//
//  ExitEvent.m
//  TestTabApp
//
//  Created by Branding Brand on 2/20/23.
//

#import "ExitEvent.h"

@implementation ExitEvent

- (instancetype)initWithComponent:(NSString *)sender
{
    self = [super init];
    if (self) {
        _invokingComponent = sender;
    }
    return self;
}

@end
