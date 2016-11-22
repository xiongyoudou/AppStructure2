//
//  UIViewController+BackButtonTouched.h

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^XYDBackButtonHandler)(UIViewController *vc);
@interface UIViewController (XYDBackButtonTouched)
/**
 *  @author XYDCategories
 *
 *  navgation 返回按钮回调
 *
 *  @param backButtonHandler <#backButtonHandler description#>
 */
-(void)xyd_backButtonTouched:(XYDBackButtonHandler)backButtonHandler;
@end
