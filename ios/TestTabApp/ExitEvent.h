//
//  ExitEvent.h
//  TestTabApp
//
//  Created by Branding Brand on 2/20/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExitEvent : NSObject

@property(nonatomic, strong) NSString *invokingComponent;

- (instancetype)initWithComponent:(NSString *)sender;

@end

NS_ASSUME_NONNULL_END
