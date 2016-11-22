//
//  NSNumber+Round.h

//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (XYDRound)
/* 展示 */
- (NSString*)xyd_toDisplayNumberWithDigit:(NSInteger)digit;
- (NSString*)xyd_toDisplayPercentageWithDigit:(NSInteger)digit;

/*　四舍五入 */
/**
 *  @brief  四舍五入
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)xyd_doRoundWithDigit:(NSUInteger)digit;
/**
 *  @brief  取上整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)xyd_doCeilWithDigit:(NSUInteger)digit;
/**
 *  @brief  取下整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)xyd_doFloorWithDigit:(NSUInteger)digit;
@end
