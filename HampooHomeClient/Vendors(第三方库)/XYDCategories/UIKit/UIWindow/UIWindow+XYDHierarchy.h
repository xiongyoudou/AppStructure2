//
//  UIWindow+XYDHierarchy.h

//
//  Created by Jakey on 15/1/16.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (XYDHierarchy)
/*!
 @method topMostController
 
 @return Returns the current Top Most ViewController in hierarchy.
 */
- (UIViewController*)xyd_topMostController;

/*!
 @method currentViewController
 
 @return Returns the topViewController in stack of topMostController.
 */
- (UIViewController*)xyd_currentViewController;


// 获取当前正显示的视图控制器
+ (UIViewController *)getShowingWindow;

// 获取当前上层的导航栏控制器
+ (UIViewController *)getShowingNaviCtrl;

// 获取当前上层的底部栏控制器
+ (UIViewController *)getShowingTabCtrl;

// 获取当前正显示的视图控制器
+ (UIViewController *)getShowingViewingCtrl;

@end
