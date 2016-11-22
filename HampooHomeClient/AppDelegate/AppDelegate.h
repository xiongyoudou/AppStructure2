//
//  AppDelegate.h
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/7.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarControllerConfig.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    BOOL _isFirstInstall;
    TabBarControllerConfig *tabBarControllerConfig;
}

@property (strong, nonatomic) UIWindow *window;


@end

