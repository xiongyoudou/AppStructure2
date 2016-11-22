//
//  AppDelegate.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/7.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+RootController.h"
#import "AppDelegate+AppService.h"
#import "AppDelegate+AppLifeCircle.h"

@interface AppDelegate () {
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 配置视图
    [self setAppWindows];
    [self setRootViewController];
    
    // 基本配置
    [self configurationLaunchUserOption];
    [self registerBugly];
    [self registerMob];
    [self registerUmeng];
    [self upLoadMessageAboutUser];
    [self checkAppUpDataWithshowOption:NO];
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
