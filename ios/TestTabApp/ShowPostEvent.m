//
//  ShowPostEvent.m
//  TestTabApp
//
//  Created by Branding Brand on 2/20/23.
//

#import "ShowPostEvent.h"

@implementation ShowPostEvent

- (instancetype)initWithPostId:(NSString *)postId component:(NSString *)sender
{
    self = [super init];
    if (self) {
        _postId = postId;
        _invokingComponent = sender;
    }
    return self;
}


@end
