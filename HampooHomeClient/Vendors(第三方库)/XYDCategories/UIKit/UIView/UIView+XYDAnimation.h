//
//  UIView+Animation.h
//  CoolUIViewAnimations
//
//  Created by Peter de Tagyos on 12/10/11.
//  Copyright (c) 2011 PT Software Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

float xyd_radiansForDegrees(int degrees);

@interface UIView (XYDAnimation)

// Moves
- (void)xyd_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)xyd_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)xyd_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)xyd_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// Transforms
- (void)xyd_rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)xyd_scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)xyd_spinClockwise:(float)secs;
- (void)xyd_spinCounterClockwise:(float)secs;

// Transitions
- (void)xyd_curlDown:(float)secs;
- (void)xyd_curlUpAndAway:(float)secs;
- (void)xyd_drainAway:(float)secs;

// Effects
- (void)xyd_changeAlpha:(float)newAlpha secs:(float)secs;
- (void)xyd_pulse:(float)secs continuously:(BOOL)continuously;

//add subview
- (void)xyd_addSubviewWithFadeAnimation:(UIView *)subview;

@end
