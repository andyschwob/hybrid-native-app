//
//  BridgeModuleEvent.h
//  TestTabApp
//
//  Created by Branding Brand on 2/1/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, Type)
{
    kExit = 0,
    kAction = 1,
    kLink = 2,
};

@interface BridgeModuleEvent : NSObject

@property(nonatomic, readonly, assign) Type eventType;
@property(nonatomic, strong) NSString *invokingComponent;
@property(nonatomic, strong) NSDictionary *data;

- (instancetype)initWithData:(NSDictionary *)data;
- (NSString *)typeDescrition;


@end

NS_ASSUME_NONNULL_END
