//
//  ShowPostEvent.h
//  TestTabApp
//
//  Created by Branding Brand on 2/20/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowPostEvent : NSObject

@property(nonatomic, strong) NSString *postId;
@property(nonatomic, strong) NSString *invokingComponent;

- (instancetype)initWithPostId:(NSString *)postId component:(NSString *)sender;

@end

NS_ASSUME_NONNULL_END
