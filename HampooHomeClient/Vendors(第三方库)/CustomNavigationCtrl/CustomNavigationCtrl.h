//
//  CustomNavigationCtrl.h
//  自我提高大杂烩
//
//  Created by iMac on 14-10-17.
//  Copyright (c) 2014年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationCtrl : UINavigationController

+ (CustomNavigationCtrl *)configNavigationCtrlwithRootVC:(UIViewController *)vc andImageName:(UIImage *)barBackgroundImage OrColor:(UIColor *)barBackColor;

@end
