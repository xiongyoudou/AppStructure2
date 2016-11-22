//
//  NSDate+Extension.h

//
//  Created by Jakey on 15/4/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XYDExtension)


/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)xyd_day;
- (NSUInteger)xyd_month;
- (NSUInteger)xyd_year;
- (NSUInteger)xyd_hour;
- (NSUInteger)xyd_minute;
- (NSUInteger)xyd_second;
+ (NSUInteger)xyd_day:(NSDate *)date;
+ (NSUInteger)xyd_month:(NSDate *)date;
+ (NSUInteger)xyd_year:(NSDate *)date;
+ (NSUInteger)xyd_hour:(NSDate *)date;
+ (NSUInteger)xyd_minute:(NSDate *)date;
+ (NSUInteger)xyd_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)xyd_daysInYear;
+ (NSUInteger)xyd_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)xyd_isLeapYear;
+ (BOOL)xyd_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)xyd_weekOfYear;
+ (NSUInteger)xyd_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)xyd_formatYMD;
+ (NSString *)xyd_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)xyd_weeksOfMonth;
+ (NSUInteger)xyd_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)xyd_begindayOfMonth;
+ (NSDate *)xyd_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)xyd_lastdayOfMonth;
+ (NSDate *)xyd_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)xyd_dateAfterDay:(NSUInteger)day;
+ (NSDate *)xyd_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)xyd_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)xyd_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)xyd_offsetYears:(int)numYears;
+ (NSDate *)xyd_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)xyd_offsetMonths:(int)numMonths;
+ (NSDate *)xyd_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)xyd_offsetDays:(int)numDays;
+ (NSDate *)xyd_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)xyd_offsetHours:(int)hours;
+ (NSDate *)xyd_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)xyd_daysAgo;
+ (NSUInteger)xyd_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)xyd_weekday;
+ (NSInteger)xyd_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)xyd_dayFromWeekday;
+ (NSString *)xyd_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)xyd_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)xyd_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)xyd_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)xyd_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)xyd_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)xyd_stringWithFormat:(NSString *)format;
+ (NSDate *)xyd_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)xyd_daysInMonth:(NSUInteger)month;
+ (NSUInteger)xyd_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)xyd_daysInMonth;
+ (NSUInteger)xyd_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)xyd_timeInfo;
+ (NSString *)xyd_timeInfoWithDate:(NSDate *)date;
+ (NSString *)xyd_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)xyd_ymdFormat;
- (NSString *)xyd_hmsFormat;
- (NSString *)xyd_ymdHmsFormat;
+ (NSString *)xyd_ymdFormat;
+ (NSString *)xyd_hmsFormat;
+ (NSString *)xyd_ymdHmsFormat;

@end
