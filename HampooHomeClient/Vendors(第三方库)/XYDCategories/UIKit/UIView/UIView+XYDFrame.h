//
//  UIView+XYDFrame.h

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYDFrame)
// shortcuts for frame properties
@property (nonatomic, assign) CGPoint xyd_origin;
@property (nonatomic, assign) CGSize xyd_size;

// shortcuts for positions
@property (nonatomic) CGFloat xyd_centerX;
@property (nonatomic) CGFloat xyd_centerY;


@property (nonatomic) CGFloat xyd_top;
@property (nonatomic) CGFloat xyd_bottom;
@property (nonatomic) CGFloat xyd_right;
@property (nonatomic) CGFloat xyd_left;

@property (nonatomic) CGFloat xyd_width;
@property (nonatomic) CGFloat xyd_height;
@end
