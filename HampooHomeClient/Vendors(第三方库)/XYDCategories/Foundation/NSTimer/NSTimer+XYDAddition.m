//
//  NSTimer+XYDAddition.m

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSTimer+XYDAddition.h"

@implementation NSTimer (XYDAddition)
/**
 *  @brief  暂停NSTimer
 */
-(void)xyd_pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}
/**
 *  @brief  开始NSTimer
 */
-(void)xyd_resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}
/**
 *  @brief  延迟开始NSTimer
 */
- (void)xyd_resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}
@end
