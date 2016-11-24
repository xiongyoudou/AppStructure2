//
//  UIView+CustomBorder.h
//  Categories
//
//  Created by luomeng on 15/11/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//
/**
 * 视图添加边框
 */

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, XYDExcludePoint) {
    XYDExcludeStartPoint = 1 << 0,
    XYDExcludeEndPoint = 1 << 1,
    XYDExcludeAllPoint = ~0UL
};


@interface UIView (XYDCustomBorder)

- (void)xyd_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)xyd_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth;
- (void)xyd_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)xyd_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;

- (void)xyd_removeTopBorder;
- (void)xyd_removeLeftBorder;
- (void)xyd_removeBottomBorder;
- (void)xyd_removeRightBorder;


- (void)xyd_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(XYDExcludePoint)edge;
- (void)xyd_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(XYDExcludePoint)edge;
- (void)xyd_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(XYDExcludePoint)edge;
- (void)xyd_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(XYDExcludePoint)edge;
@end
