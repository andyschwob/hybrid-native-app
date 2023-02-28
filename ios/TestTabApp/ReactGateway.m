//
//  BBReactNativeViewController.m
//  TestTabApp
//
//  Created by Branding Brand on 1/31/23.
//

#import "ReactGateway.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "ShowPostEvent.h"
#import "ExitEvent.h"
#import "DeepLinkEvent.h"
#import "TestTabApp-Swift.h"


@interface ReactGateway ()

@property (nonatomic, strong) RCTBridge *bridge;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDictionary *props;


@end

@implementation ReactGateway

- (instancetype)initWithBridge:(RCTBridge *)bridge
                      moduleName:(NSString *)name
                    initialProps:(nullable NSDictionary *)props
{
    self = [super init];
    _bridge = bridge;
    _name = name;
    _props = props;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:self.bridge
                                                      moduleName:self.name
                                               initialProperties:self.props];
    self.view = rootView;
}

@end
