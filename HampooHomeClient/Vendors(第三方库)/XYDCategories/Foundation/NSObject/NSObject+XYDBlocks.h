//
//  NSObject+XYDBlocks.h
//  PSFoundation
//
//  Created by Peter Steinberger on 24.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSObject (XYDBlocks)
+ (id)xyd_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
+ (id)xyd_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
- (id)xyd_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)xyd_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
+ (void)xyd_cancelBlock:(id)block;
+ (void)xyd_cancelPreviousPerformBlock:(id)aWrappingBlockHandle __attribute__ ((deprecated));

@end
