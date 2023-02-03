//
//  BBReactNativeViewController.m
//  TestTabApp
//
//  Created by Branding Brand on 1/31/23.
//

#import "ReactGateway.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTBridgeModule.h>
#import "BridgeModuleConstants.h"

@interface ReactGateway ()

@property (nonatomic, strong) NSURL *bundle;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDictionary *props;


@end

@implementation ReactGateway
@synthesize delegate;

- (instancetype)initWithJsBundle:(NSURL*)bundle
                      moduleName:(NSString *)name
                    initialProps:(nullable NSDictionary *)props
{
    self = [super init];
    _bundle = bundle;
    _name = name;
    _props = props;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:self.bundle
                                                        moduleName:self.name
                                                 initialProperties:self.props
                                                     launchOptions:nil];
    self.view = rootView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveMessage:)
                                                 name:ReactBridgeEvent
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMessage:(NSNotification *)notification
{
    if (![notification.userInfo isEqual:(id) [NSNull class]]){
        BridgeModuleEvent *event = [[BridgeModuleEvent alloc] initWithData:notification.userInfo];
        [delegate didReceiveReactApplicationEvent:event];
    }
}

@end
