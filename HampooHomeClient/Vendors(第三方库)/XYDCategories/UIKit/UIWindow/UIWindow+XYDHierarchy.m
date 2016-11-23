//
//  UIWindow+XYDHierarchy.m

//
//  Created by Jakey on 15/1/16.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIWindow+XYDHierarchy.h"

@implementation UIWindow (XYDHierarchy)
- (UIViewController*)xyd_topMostController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)xyd_currentViewController;
{
    UIViewController *currentViewController = [self xyd_topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}

// 获取当前正显示的视图控制器
+ (UIViewController *)getShowingWindow {
    UIViewController *returnCtrl = [self getShowingWithType:1];
    return  returnCtrl;
}

// 获取当前上层的导航栏控制器
+ (UIViewController *)getShowingNaviCtrl {
    UIViewController *returnCtrl = [self getShowingWithType:2];
    return  returnCtrl;
}

// 获取当前上层的底部栏控制器
+ (UIViewController *)getShowingTabCtrl {
    UIViewController *returnCtrl = [self getShowingWithType:3];
    return  returnCtrl;
}

// 获取当前正显示的视图控制器
+ (UIViewController *)getShowingViewingCtrl {
    UIViewController *returnCtrl = [self getShowingWithType:4];
    return  returnCtrl;
}

// 获取当前活跃控制器方法
+ (id)getShowingWithType:(NSInteger)getType {
    UIViewController* activityViewController = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if(tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    if (getType == 1)return window;
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0){
        UIView *frontView = [viewsArray objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            activityViewController = nextResponder;
        }else {
            activityViewController = window.rootViewController;
        }
    }
    return [self getRealShowingWithCtrl:activityViewController withType:getType];
}

+ (UIViewController *)getRealShowingWithCtrl:(UIViewController *)ctrl withType:(NSInteger)getType{
    UIViewController *resultCtrl;
    if ([ctrl isKindOfClass:[UINavigationController class]]) {
        resultCtrl = [[(UINavigationController *)ctrl viewControllers] lastObject];
        if (getType == 2)return resultCtrl;
        return [self getRealShowingWithCtrl:resultCtrl withType:getType];
    }else if ([ctrl isKindOfClass:[UITabBarController class]]) {
        resultCtrl = [(UITabBarController *)ctrl selectedViewController];
        if (getType == 3)return resultCtrl;
        return [self getRealShowingWithCtrl:resultCtrl withType:getType];
    } else {
        resultCtrl = ctrl;
        if (getType == 4)return resultCtrl;
        else return nil;
    }
}

@end
