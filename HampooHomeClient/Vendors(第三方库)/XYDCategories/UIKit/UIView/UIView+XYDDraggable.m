//
//  UIView+draggable.m
//  UIView+draggable
//
//  Created by Andrea on 13/03/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UIView+XYDDraggable.h"
#import <objc/runtime.h>

@implementation UIView (XYDDraggable)

- (void)setXyd_panGesture:(UIPanGestureRecognizer*)panGesture
{
    objc_setAssociatedObject(self, @selector(xyd_panGesture), panGesture, OBJC_ASSOCIATION_RETAIN);
}

- (UIPanGestureRecognizer*)xyd_panGesture
{
    return objc_getAssociatedObject(self, @selector(xyd_panGesture));
}

- (void)setXyd_cagingArea:(CGRect)cagingArea
{
    if (CGRectEqualToRect(cagingArea, CGRectZero) ||
        CGRectContainsRect(cagingArea, self.frame)) {
        NSValue *cagingAreaValue = [NSValue valueWithCGRect:cagingArea];
        objc_setAssociatedObject(self, @selector(xyd_cagingArea), cagingAreaValue, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CGRect)xyd_cagingArea
{
    NSValue *cagingAreaValue = objc_getAssociatedObject(self, @selector(xyd_cagingArea));
    return [cagingAreaValue CGRectValue];
}

- (void)setXyd_handle:(CGRect)handle
{
    CGRect relativeFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsRect(relativeFrame, handle)) {
        NSValue *handleValue = [NSValue valueWithCGRect:handle];
        objc_setAssociatedObject(self, @selector(xyd_handle), handleValue, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CGRect)xyd_handle
{
    NSValue *handleValue = objc_getAssociatedObject(self, @selector(xyd_handle));
    return [handleValue CGRectValue];
}

- (void)setXyd_shouldMoveAlongY:(BOOL)newShould
{
    NSNumber *shouldMoveAlongYBool = [NSNumber numberWithBool:newShould];
    objc_setAssociatedObject(self, @selector(xyd_shouldMoveAlongY), shouldMoveAlongYBool, OBJC_ASSOCIATION_RETAIN );
}

- (BOOL)xyd_shouldMoveAlongY
{
    NSNumber *moveAlongY = objc_getAssociatedObject(self, @selector(xyd_shouldMoveAlongY));
    return (moveAlongY) ? [moveAlongY boolValue] : YES;
}

- (void)setXyd_shouldMoveAlongX:(BOOL)newShould
{
    NSNumber *shouldMoveAlongXBool = [NSNumber numberWithBool:newShould];
    objc_setAssociatedObject(self, @selector(xyd_shouldMoveAlongX), shouldMoveAlongXBool, OBJC_ASSOCIATION_RETAIN );
}

- (BOOL)xyd_shouldMoveAlongX
{
    NSNumber *moveAlongX = objc_getAssociatedObject(self, @selector(xyd_shouldMoveAlongX));
    return (moveAlongX) ? [moveAlongX boolValue] : YES;
}

- (void)setXyd_draggingStartedBlock:(void (^)())draggingStartedBlock
{
    objc_setAssociatedObject(self, @selector(xyd_draggingStartedBlock), draggingStartedBlock, OBJC_ASSOCIATION_RETAIN);
}

- (void (^)())xyd_draggingStartedBlock
{
    return objc_getAssociatedObject(self, @selector(xyd_draggingStartedBlock));
}

- (void)setXyd_draggingEndedBlock:(void (^)())draggingEndedBlock
{
    objc_setAssociatedObject(self, @selector(xyd_draggingEndedBlock), draggingEndedBlock, OBJC_ASSOCIATION_RETAIN);
}

- (void (^)())xyd_draggingEndedBlock
{
    return objc_getAssociatedObject(self, @selector(xyd_draggingEndedBlock));
}

- (void)xyd_handlePan:(UIPanGestureRecognizer*)sender
{
    // Check to make you drag from dragging area
    CGPoint locationInView = [sender locationInView:self];
    if (!CGRectContainsPoint(self.xyd_handle, locationInView)) {
        return;
    }
    
    [self xyd_adjustAnchorPointForGestureRecognizer:sender];
    
    if (sender.state == UIGestureRecognizerStateBegan && self.xyd_draggingStartedBlock) {
        self.xyd_draggingStartedBlock();
    }
    
    if (sender.state == UIGestureRecognizerStateEnded && self.xyd_draggingEndedBlock) {
        self.xyd_draggingEndedBlock();
    }
    
    CGPoint translation = [sender translationInView:[self superview]];
    
    CGFloat newXOrigin = CGRectGetMinX(self.frame) + (([self xyd_shouldMoveAlongX]) ? translation.x : 0);
    CGFloat newYOrigin = CGRectGetMinY(self.frame) + (([self xyd_shouldMoveAlongY]) ? translation.y : 0);
    
    CGRect cagingArea = self.xyd_cagingArea;
    
    CGFloat cagingAreaOriginX = CGRectGetMinX(cagingArea);
    CGFloat cagingAreaOriginY = CGRectGetMinY(cagingArea);
    
    CGFloat cagingAreaRightSide = cagingAreaOriginX + CGRectGetWidth(cagingArea);
    CGFloat cagingAreaBottomSide = cagingAreaOriginY + CGRectGetHeight(cagingArea);
    
    if (!CGRectEqualToRect(cagingArea, CGRectZero)) {
        
        // Check to make sure the view is still within the caging area
        if (newXOrigin <= cagingAreaOriginX ||
            newYOrigin <= cagingAreaOriginY ||
            newXOrigin + CGRectGetWidth(self.frame) >= cagingAreaRightSide ||
            newYOrigin + CGRectGetHeight(self.frame) >= cagingAreaBottomSide) {
            
            // Don't move
            newXOrigin = CGRectGetMinX(self.frame);
            newYOrigin = CGRectGetMinY(self.frame);
        }
    }
    
    [self setFrame:CGRectMake(newXOrigin,
                              newYOrigin,
                              CGRectGetWidth(self.frame),
                              CGRectGetHeight(self.frame))];
    
    [sender setTranslation:(CGPoint){0, 0} inView:[self superview]];
}

- (void)xyd_adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = self;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void)xyd_setDraggable:(BOOL)draggable
{
    [self.xyd_panGesture setEnabled:draggable];
}

- (void)xyd_enableDragging
{
    self.xyd_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(xyd_handlePan:)];
    [self.xyd_panGesture setMaximumNumberOfTouches:1];
    [self.xyd_panGesture setMinimumNumberOfTouches:1];
    [self.xyd_panGesture setCancelsTouchesInView:NO];
    [self setXyd_handle:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addGestureRecognizer:self.xyd_panGesture];
}

@end
