//
//  ShowPostProps.h
//  TestTabApp
//
//  Created by Branding Brand on 2/28/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowPostProps : NSObject

@property(nonatomic, strong) NSString *invokingComponent;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *postId;
@property(nonatomic, strong) NSString *json;
@property(nonatomic, strong) NSDictionary *dynamicData;

- (instancetype)initWithDataDictionary:(NSDictionary *)dataDictionary;
- (BOOL)areValidProps;
- (NSDictionary *)getJSObjectRepresenation;


@end

NS_ASSUME_NONNULL_END
