//
//  UIView+UIView_BlockGesture.h

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^XYDGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (XYDBlockGesture)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)xyd_addTapActionWithBlock:(XYDGestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)xyd_addLongPressActionWithBlock:(XYDGestureActionBlock)block;
@end
