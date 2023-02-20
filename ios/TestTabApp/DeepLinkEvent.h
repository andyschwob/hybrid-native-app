//
//  DeepLinkEvent.h
//  TestTabApp
//
//  Created by Branding Brand on 2/20/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeepLinkEvent : NSObject

@property(nonatomic, strong) NSURL *url;
@property(nonatomic, strong) NSString *invokingComponent;

- (instancetype)initWithDestinationURL:(NSURL *)url component:(NSString *)sender;

@end

NS_ASSUME_NONNULL_END
