//
//  XYDBottomBarData.h
//  MiniPC
//
//  Created by xiongyoudou on 16/5/16.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYDBottomBarData : NSObject

@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *imageName;

@property (weak,nonatomic)UIViewController *subViewController;

+(id)getBarDataWith:(NSString *)title imageName:(NSString *)name ctrl:(UIViewController *)ctrl;

@end
