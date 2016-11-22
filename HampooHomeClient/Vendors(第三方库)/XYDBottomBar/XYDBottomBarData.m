//
//  XYDBottomBarData.m
//  MiniPC
//
//  Created by xiongyoudou on 16/5/16.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "XYDBottomBarData.h"

@implementation XYDBottomBarData

+(id)getBarDataWith:(NSString *)title imageName:(NSString *)name ctrl:(UIViewController *)ctrl {
    XYDBottomBarData *data = [[XYDBottomBarData alloc]init];
    data.title = title;
    data.imageName = name;
    data.subViewController = ctrl;
    return data;
}

@end
