//
//  UIView+Shake.m
//  UIView+Shake
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UIView+XYDShake.h"

@implementation UIView (XYDShake)

- (void)xyd_shake {
    [self _xyd_shake:10 direction:1 currentTimes:0 withDelta:5 speed:0.03 shakeDirection:XYDShakeDirectionHorizontal completion:nil];
}

- (void)xyd_shake:(int)times withDelta:(CGFloat)delta {
    [self _xyd_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:XYDShakeDirectionHorizontal completion:nil];
}

- (void)xyd_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)())handler {
    [self _xyd_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:XYDShakeDirectionHorizontal completion:handler];
}

- (void)xyd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self _xyd_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:XYDShakeDirectionHorizontal completion:nil];
}

- (void)xyd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)())handler {
    [self _xyd_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:XYDShakeDirectionHorizontal completion:handler];
}

- (void)xyd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(XYDShakeDirection)shakeDirection {
    [self _xyd_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)xyd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(XYDShakeDirection)shakeDirection completion:(void (^)(void))completion {
    [self _xyd_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:completion];
}

- (void)_xyd_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(XYDShakeDirection)shakeDirection completion:(void (^)(void))completionHandler {
    [UIView animateWithDuration:interval animations:^{
        self.layer.affineTransform = (shakeDirection == XYDShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.layer.affineTransform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                if (completionHandler != nil) {
                    completionHandler();
                }
            }];
            return;
        }
        [self _xyd_shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
               speed:interval
      shakeDirection:shakeDirection
          completion:completionHandler];
    }];
}

@end
