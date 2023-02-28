//
//  ShowPostEvent.h
//  TestTabApp
//
//  Created by Branding Brand on 2/20/23.
//

#import <Foundation/Foundation.h>
#import "ShowPostProps.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShowPostEvent : NSObject

@property(nonatomic, strong) ShowPostProps *props;

- (instancetype)initWithEventData:(NSDictionary *)data;
- (BOOL)isValidEvent;


@end

NS_ASSUME_NONNULL_END
