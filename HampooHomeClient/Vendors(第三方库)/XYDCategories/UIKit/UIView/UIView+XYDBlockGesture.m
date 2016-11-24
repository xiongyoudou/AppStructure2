//
//  UIView+UIView_BlockGesture.m

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+XYDBlockGesture.h"
#import <objc/runtime.h>
static char xyd_kActionHandlerTapBlockKey;
static char xyd_kActionHandlerTapGestureKey;
static char xyd_kActionHandlerLongPressBlockKey;
static char xyd_kActionHandlerLongPressGestureKey;

@implementation UIView (XYDBlockGesture)
- (void)xyd_addTapActionWithBlock:(XYDGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &xyd_kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xyd_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &xyd_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &xyd_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)xyd_handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        XYDGestureActionBlock block = objc_getAssociatedObject(self, &xyd_kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
- (void)xyd_addLongPressActionWithBlock:(XYDGestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &xyd_kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(xyd_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &xyd_kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &xyd_kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)xyd_handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        XYDGestureActionBlock block = objc_getAssociatedObject(self, &xyd_kActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
@end
