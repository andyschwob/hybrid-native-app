//
//  DeepLinkEvent.m
//  TestTabApp
//
//  Created by Branding Brand on 2/20/23.
//

#import "DeepLinkEvent.h"

@implementation DeepLinkEvent

- (instancetype)initWithDestinationURL:(NSURL *)url component:(NSString *)sender
{
    self = [super init];
    if (self) {
        _url = url;
        _invokingComponent = sender;
    }
    return self;
}

@end
