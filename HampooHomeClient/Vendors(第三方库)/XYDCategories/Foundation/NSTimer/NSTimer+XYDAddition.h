//
//  NSTimer+XYDAddition.h

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (XYDAddition)
/**
 *  @brief  暂停NSTimer
 */
- (void)xyd_pauseTimer;
/**
 *  @brief  开始NSTimer
 */
- (void)xyd_resumeTimer;
/**
 *  @brief  延迟开始NSTimer
 */
- (void)xyd_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
