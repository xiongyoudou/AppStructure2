//
//  UIScrollView+XYDPages.h

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (XYDPages)
- (NSInteger)xyd_pages;
- (NSInteger)xyd_currentPage;
- (CGFloat)xyd_scrollPercent;

- (CGFloat)xyd_pagesY;
- (CGFloat)xyd_pagesX;
- (CGFloat)xyd_currentPageY;
- (CGFloat)xyd_currentPageX;
- (void)xyd_setPageY:(CGFloat)page;
- (void)xyd_setPageX:(CGFloat)page;
- (void)xyd_setPageY:(CGFloat)page animated:(BOOL)animated;
- (void)xyd_setPageX:(CGFloat)page animated:(BOOL)animated;
@end
