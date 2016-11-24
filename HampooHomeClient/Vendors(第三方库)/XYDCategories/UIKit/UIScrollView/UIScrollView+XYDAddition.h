//
//  UIScrollView+XYDAddition.h

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XYDScrollDirection) {
    XYDScrollDirectionUp,
    XYDScrollDirectionDown,
    XYDScrollDirectionLeft,
    XYDScrollDirectionRight,
    XYDScrollDirectionWTF
};

@interface UIScrollView (XYDAddition)
@property(nonatomic) CGFloat xyd_contentWidth;
@property(nonatomic) CGFloat xyd_contentHeight;
@property(nonatomic) CGFloat xyd_contentOffsetX;
@property(nonatomic) CGFloat xyd_contentOffsetY;

- (CGPoint)xyd_topContentOffset;
- (CGPoint)xyd_bottomContentOffset;
- (CGPoint)xyd_leftContentOffset;
- (CGPoint)xyd_rightContentOffset;

- (XYDScrollDirection)xyd_ScrollDirection;

- (BOOL)xyd_isScrolledToTop;
- (BOOL)xyd_isScrolledToBottom;
- (BOOL)xyd_isScrolledToLeft;
- (BOOL)xyd_isScrolledToRight;
- (void)xyd_scrollToTopAnimated:(BOOL)animated;
- (void)xyd_scrollToBottomAnimated:(BOOL)animated;
- (void)xyd_scrollToLeftAnimated:(BOOL)animated;
- (void)xyd_scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)xyd_verticalPageIndex;
- (NSUInteger)xyd_horizontalPageIndex;

- (void)xyd_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)xyd_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
@end
