//
//  NSDate+Extension.m

//
//  Created by Jakey on 15/4/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  https://github.com/632840804/HYBNSDateExtension

#import "NSDate+XYDExtension.h"

@implementation NSDate (XYDExtension)

- (NSUInteger)xyd_day {
    return [NSDate xyd_day:self];
}

- (NSUInteger)xyd_month {
    return [NSDate xyd_month:self];
}

- (NSUInteger)xyd_year {
    return [NSDate xyd_year:self];
}

- (NSUInteger)xyd_hour {
    return [NSDate xyd_hour:self];
}

- (NSUInteger)xyd_minute {
    return [NSDate xyd_minute:self];
}

- (NSUInteger)xyd_second {
    return [NSDate xyd_second:self];
}

+ (NSUInteger)xyd_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)xyd_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)xyd_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)xyd_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)xyd_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)xyd_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)xyd_daysInYear {
    return [NSDate xyd_daysInYear:self];
}

+ (NSUInteger)xyd_daysInYear:(NSDate *)date {
    return [self xyd_isLeapYear:date] ? 366 : 365;
}

- (BOOL)xyd_isLeapYear {
    return [NSDate xyd_isLeapYear:self];
}

+ (BOOL)xyd_isLeapYear:(NSDate *)date {
    NSUInteger year = [date xyd_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)xyd_formatYMD {
    return [NSDate xyd_formatYMD:self];
}

+ (NSString *)xyd_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",[date xyd_year],[date xyd_month], [date xyd_day]];
}

- (NSUInteger)xyd_weeksOfMonth {
    return [NSDate xyd_weeksOfMonth:self];
}

+ (NSUInteger)xyd_weeksOfMonth:(NSDate *)date {
    return [[date xyd_lastdayOfMonth] xyd_weekOfYear] - [[date xyd_begindayOfMonth] xyd_weekOfYear] + 1;
}

- (NSUInteger)xyd_weekOfYear {
    return [NSDate xyd_weekOfYear:self];
}

+ (NSUInteger)xyd_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date xyd_year];
    
    NSDate *lastdate = [date xyd_lastdayOfMonth];
    
    for (i = 1;[[lastdate xyd_dateAfterDay:-7 * i] xyd_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)xyd_dateAfterDay:(NSUInteger)day {
    return [NSDate xyd_dateAfterDate:self day:day];
}

+ (NSDate *)xyd_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)xyd_dateAfterMonth:(NSUInteger)month {
    return [NSDate xyd_dateAfterDate:self month:month];
}

+ (NSDate *)xyd_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)xyd_begindayOfMonth {
    return [NSDate xyd_begindayOfMonth:self];
}

+ (NSDate *)xyd_begindayOfMonth:(NSDate *)date {
    return [self xyd_dateAfterDate:date day:-[date xyd_day] + 1];
}

- (NSDate *)xyd_lastdayOfMonth {
    return [NSDate xyd_lastdayOfMonth:self];
}

+ (NSDate *)xyd_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self xyd_begindayOfMonth:date];
    return [[lastDate xyd_dateAfterMonth:1] xyd_dateAfterDay:-1];
}

- (NSUInteger)xyd_daysAgo {
    return [NSDate xyd_daysAgo:self];
}

+ (NSUInteger)xyd_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)xyd_weekday {
    return [NSDate xyd_weekday:self];
}

+ (NSInteger)xyd_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)xyd_dayFromWeekday {
    return [NSDate xyd_dayFromWeekday:self];
}

+ (NSString *)xyd_dayFromWeekday:(NSDate *)date {
    switch([date xyd_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)xyd_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)xyd_isToday {
    return [self xyd_isSameDay:[NSDate date]];
}

- (NSDate *)xyd_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

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
+ (NSString *)xyd_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)xyd_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date xyd_stringWithFormat:format];
}

- (NSString *)xyd_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)xyd_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)xyd_daysInMonth:(NSUInteger)month {
    return [NSDate xyd_daysInMonth:self month:month];
}

+ (NSUInteger)xyd_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date xyd_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)xyd_daysInMonth {
    return [NSDate xyd_daysInMonth:self];
}

+ (NSUInteger)xyd_daysInMonth:(NSDate *)date {
    return [self xyd_daysInMonth:date month:[date xyd_month]];
}

- (NSString *)xyd_timeInfo {
    return [NSDate xyd_timeInfoWithDate:self];
}

+ (NSString *)xyd_timeInfoWithDate:(NSDate *)date {
    return [self xyd_timeInfoWithDateString:[self xyd_stringWithDate:date format:[self xyd_ymdHmsFormat]]];
}

+ (NSString *)xyd_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self xyd_dateWithString:dateString format:[self xyd_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate xyd_month] - [date xyd_month]);
    int year = (int)([curDate xyd_year] - [date xyd_year]);
    int day = (int)([curDate xyd_day] - [date xyd_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate xyd_month] == 1 && [date xyd_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self xyd_daysInMonth:date month:[date xyd_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate xyd_day] + (totalDays - (int)[date xyd_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate xyd_month];
            int preMonth = (int)[date xyd_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)xyd_ymdFormat {
    return [NSDate xyd_ymdFormat];
}

- (NSString *)xyd_hmsFormat {
    return [NSDate xyd_hmsFormat];
}

- (NSString *)xyd_ymdHmsFormat {
    return [NSDate xyd_ymdHmsFormat];
}

+ (NSString *)xyd_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)xyd_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)xyd_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self xyd_ymdFormat], [self xyd_hmsFormat]];
}

- (NSDate *)xyd_offsetYears:(int)numYears {
    return [NSDate xyd_offsetYears:numYears fromDate:self];
}

+ (NSDate *)xyd_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)xyd_offsetMonths:(int)numMonths {
    return [NSDate xyd_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)xyd_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)xyd_offsetDays:(int)numDays {
    return [NSDate xyd_offsetDays:numDays fromDate:self];
}

+ (NSDate *)xyd_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)xyd_offsetHours:(int)hours {
    return [NSDate xyd_offsetHours:hours fromDate:self];
}

+ (NSDate *)xyd_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}
@end
