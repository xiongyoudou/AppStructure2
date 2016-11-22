//
//  UIView+Recursion.h
//  XYDCategories
//
//  Created by Jakey on 15/6/23.
//  Copyright © 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^XYDSubviewBlock) (UIView* view);
typedef void (^XYDSuperviewBlock) (UIView* superview);
@interface UIView (XYDRecursion)

/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView*)xyd_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;


-(void)xyd_runBlockOnAllSubviews:(XYDSubviewBlock)block;
-(void)xyd_runBlockOnAllSuperviews:(XYDSuperviewBlock)block;
-(void)xyd_enableAllControlsInViewHierarchy;
-(void)xyd_disableAllControlsInViewHierarchy;
@end
