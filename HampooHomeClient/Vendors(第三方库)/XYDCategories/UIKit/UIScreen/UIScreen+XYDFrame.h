//
//  UIScreen+XYDFrame.h

//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (XYDFrame)
+ (CGSize)xyd_size;
+ (CGFloat)xyd_width;
+ (CGFloat)xyd_height;

+ (CGSize)xyd_orientationSize;
+ (CGFloat)xyd_orientationWidth;
+ (CGFloat)xyd_orientationHeight;
+ (CGSize)xyd_DPISize;

@end
