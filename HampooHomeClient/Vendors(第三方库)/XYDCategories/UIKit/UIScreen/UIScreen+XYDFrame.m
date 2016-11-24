//
//  UIScreen+XYDFrame.m

//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIScreen+XYDFrame.h"

@implementation UIScreen (XYDFrame)
+ (CGSize)xyd_size
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)xyd_width
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)xyd_height
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)xyd_orientationSize
{
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion]
                             doubleValue];
    BOOL isLand =   UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    return (systemVersion>8.0 && isLand) ? xyd_SizeSWAP([UIScreen xyd_size]) : [UIScreen xyd_size];
}

+ (CGFloat)xyd_orientationWidth
{
    return [UIScreen xyd_orientationSize].width;
}

+ (CGFloat)xyd_orientationHeight
{
    return [UIScreen xyd_orientationSize].height;
}

+ (CGSize)xyd_DPISize
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}


/**
 *  交换高度与宽度
 */
static inline CGSize xyd_SizeSWAP(CGSize size) {
    return CGSizeMake(size.height, size.width);
}
@end
