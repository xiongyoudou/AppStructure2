//
//  CALayer+XYDBorderColor.m
//  test
//
//  Created by LiuLogan on 15/6/17.
//  Copyright (c) 2015年 Xidibuy. All rights reserved.
//

#import "CALayer+XYDBorderColor.h"

@implementation CALayer (XYDBorderColor)

-(void)setXyd_borderColor:(UIColor *)xyd_borderColor{
    self.borderColor = xyd_borderColor.CGColor;
}

- (UIColor*)xyd_borderColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
