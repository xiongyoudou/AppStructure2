//
//  UIWebView+style.m
//  XYDCategories
//
//  Created by jakey on 14-3-11.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIWebView+XYDStyle.h"

@implementation UIWebView (XYDStyle)
/**
 *  @brief  是否显示阴影
 *
 *  @param b 是否显示阴影
 */
- (void)xyd_shadowViewHidden:(BOOL)hidden{
    for (UIView *aView in [self subviews])
    {
        if ([aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)aView setShowsHorizontalScrollIndicator:NO];
            for (UIView *shadowView in aView.subviews)
            {
                if ([shadowView isKindOfClass:[UIImageView class]])
                {
                    shadowView.hidden = hidden;  //上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                }
            }
        }
    }
}
/**
 *  @brief  是否显示水平滑动指示器
 *
 *  @param b 是否显示水平滑动指示器
 */
- (void)xyd_showsHorizontalScrollIndicator:(BOOL)hidden{
    for (UIView *aView in [self subviews])
    {
        if ([aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)aView setShowsHorizontalScrollIndicator:hidden];
        }
    }
}
/**
 *  @brief  是否显示垂直滑动指示器
 *
 *  @param b 是否显示垂直滑动指示器
 */
- (void)xyd_showsVerticalScrollIndicator:(BOOL)hidden{
    for (UIView *aView in [self subviews])
    {
        if ([aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)aView setShowsVerticalScrollIndicator:hidden];
        }
    }
}
/**
 *  @brief  网页透明
 */
-(void)xyd_makeTransparent
{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
}
/**
 *  @brief  网页透明移除阴影
 */
-(void)xyd_makeTransparentAndRemoveShadow
{
    [self xyd_makeTransparent];
    [self xyd_shadowViewHidden:YES];
}
@end
