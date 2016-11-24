//
//  UIScrollView+XYDAddition.m

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIScrollView+XYDAddition.h"

@implementation UIScrollView (XYDAddition)
//frame
- (CGFloat)xyd_contentWidth {
    return self.contentSize.width;
}
- (void)setXyd_contentWidth:(CGFloat)width {
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}
- (CGFloat)xyd_contentHeight {
    return self.contentSize.height;
}
- (void)setXyd_contentHeight:(CGFloat)height {
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}
- (CGFloat)xyd_contentOffsetX {
    return self.contentOffset.x;
}
- (void)setXyd_contentOffsetX:(CGFloat)x {
    self.contentOffset = CGPointMake(x, self.contentOffset.y);
}
- (CGFloat)xyd_contentOffsetY {
    return self.contentOffset.y;
}
- (void)setXyd_contentOffsetY:(CGFloat)y {
    self.contentOffset = CGPointMake(self.contentOffset.x, y);
}
//


- (CGPoint)xyd_topContentOffset
{
    return CGPointMake(0.0f, -self.contentInset.top);
}
- (CGPoint)xyd_bottomContentOffset
{
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}
- (CGPoint)xyd_leftContentOffset
{
    return CGPointMake(-self.contentInset.left, 0.0f);
}
- (CGPoint)xyd_rightContentOffset
{
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}
- (XYDScrollDirection)xyd_ScrollDirection
{
    XYDScrollDirection direction;
    
    if ([self.panGestureRecognizer translationInView:self.superview].y > 0.0f)
    {
        direction = XYDScrollDirectionUp;
    }
    else if ([self.panGestureRecognizer translationInView:self.superview].y < 0.0f)
    {
        direction = XYDScrollDirectionDown;
    }
    else if ([self.panGestureRecognizer translationInView:self].x < 0.0f)
    {
        direction = XYDScrollDirectionLeft;
    }
    else if ([self.panGestureRecognizer translationInView:self].x > 0.0f)
    {
        direction = XYDScrollDirectionRight;
    }
    else
    {
        direction = XYDScrollDirectionWTF;
    }
    
    return direction;
}
- (BOOL)xyd_isScrolledToTop
{
    return self.contentOffset.y <= [self xyd_topContentOffset].y;
}
- (BOOL)xyd_isScrolledToBottom
{
    return self.contentOffset.y >= [self xyd_bottomContentOffset].y;
}
- (BOOL)xyd_isScrolledToLeft
{
    return self.contentOffset.x <= [self xyd_leftContentOffset].x;
}
- (BOOL)xyd_isScrolledToRight
{
    return self.contentOffset.x >= [self xyd_rightContentOffset].x;
}
- (void)xyd_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:[self xyd_topContentOffset] animated:animated];
}
- (void)xyd_scrollToBottomAnimated:(BOOL)animated
{
    [self setContentOffset:[self xyd_bottomContentOffset] animated:animated];
}
- (void)xyd_scrollToLeftAnimated:(BOOL)animated
{
    [self setContentOffset:[self xyd_leftContentOffset] animated:animated];
}
- (void)xyd_scrollToRightAnimated:(BOOL)animated
{
    [self setContentOffset:[self xyd_rightContentOffset] animated:animated];
}
- (NSUInteger)xyd_verticalPageIndex
{
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}
- (NSUInteger)xyd_horizontalPageIndex
{
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}
- (void)xyd_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}
- (void)xyd_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}


@end
