//
//  UIView+Visuals.h
//
//  Created by Heiko Dreyer on 25.05.11.
//  Copyright 2011 boxedfolder.com. All rights reserved.
//  https://github.com/bfolder/UIView-Visuals

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface UIView (XYDVisuals)

/*
 *  Sets a corners with radius, given stroke size & color
 */
-(void)xyd_cornerRadius: (CGFloat)radius
         strokeSize: (CGFloat)size 
              color: (UIColor *)color;
/*
 *  Sets a corners
 */
-(void)xyd_setRoundedCorners:(UIRectCorner)corners
                  radius:(CGFloat)radius;

/*
 *  Draws shadow with properties
 */
-(void)xyd_shadowWithColor: (UIColor *)color
                offset: (CGSize)offset 
               opacity: (CGFloat)opacity 
                radius: (CGFloat)radius;

/*
 *  Removes from superview with fade
 */
-(void)xyd_removeFromSuperviewWithFadeDuration: (NSTimeInterval)duration;

/*
 *  Adds a subview with given transition & duration
 */
-(void)xyd_addSubview: (UIView *)view withTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Removes view from superview with given transition & duration
 */
-(void)xyd_removeFromSuperviewWithTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Rotates view by given angle. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)xyd_rotateByAngle: (CGFloat)angle
            duration: (NSTimeInterval)duration 
         autoreverse: (BOOL)autoreverse
         repeatCount: (CGFloat)repeatCount
      timingFunction: (CAMediaTimingFunction *)timingFunction;

/*
 *  Moves view to point. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)xyd_moveToPoint: (CGPoint)newPoint 
          duration: (NSTimeInterval)duration 
       autoreverse: (BOOL)autoreverse
       repeatCount: (CGFloat)repeatCount
    timingFunction: (CAMediaTimingFunction *)timingFunction;

@end
