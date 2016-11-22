//
//  UIView+XYDFrame.m

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+XYDFrame.h"

@implementation UIView (XYDFrame)
#pragma mark - Shortcuts for the coords

- (CGFloat)xyd_top
{
    return self.frame.origin.y;
}

- (void)setXyd_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)xyd_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setXyd_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)xyd_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setXyd_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)xyd_left
{
    return self.frame.origin.x;
}

- (void)setXyd_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)xyd_width
{
    return self.frame.size.width;
}

- (void)setXyd_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)xyd_height
{
    return self.frame.size.height;
}

- (void)setXyd_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)xyd_origin {
    return self.frame.origin;
}

- (void)setXyd_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)xyd_size {
    return self.frame.size;
}

- (void)setXyd_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)xyd_centerX {
    return self.center.x;
}

- (void)setXyd_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)xyd_centerY {
    return self.center.y;
}

- (void)setXyd_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

@end
