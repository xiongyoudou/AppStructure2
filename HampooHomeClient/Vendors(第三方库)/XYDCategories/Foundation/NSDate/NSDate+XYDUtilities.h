//
//  NSDate+Utilities.h

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#define D_MINUTE	60
#define D_HOUR	3600
#define D_DAY	86400
#define D_WEEK	604800
#define D_YEAR	31556926
@interface NSDate (XYDUtilities)

+ (NSCalendar *)xyd_currentCalendar; // avoid bottlenecks

// Relative dates from the current date
+ (NSDate *)xyd_dateTomorrow;
+ (NSDate *)xyd_dateYesterday;
+ (NSDate *)xyd_dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *)xyd_dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *)xyd_dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *)xyd_dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *)xyd_dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *)xyd_dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Short string utilities
- (NSString *)xyd_stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;
- (NSString *)xyd_stringWithFormat: (NSString *) format;

@property (nonatomic, readonly) NSString *xyd_shortString;
@property (nonatomic, readonly) NSString *xyd_shortDateString;
@property (nonatomic, readonly) NSString *xyd_shortTimeString;
@property (nonatomic, readonly) NSString *xyd_mediumString;
@property (nonatomic, readonly) NSString *xyd_mediumDateString;
@property (nonatomic, readonly) NSString *xyd_mediumTimeString;
@property (nonatomic, readonly) NSString *xyd_longString;
@property (nonatomic, readonly) NSString *xyd_longDateString;
@property (nonatomic, readonly) NSString *xyd_longTimeString;



// Comparing dates
- (BOOL)xyd_isEqualToDateIgnoringTime: (NSDate *) aDate;

- (BOOL)xyd_isToday;
- (BOOL)xyd_isTomorrow;
- (BOOL)xyd_isYesterday;

- (BOOL)xyd_isSameWeekAsDate: (NSDate *) aDate;
- (BOOL)xyd_isThisWeek;
- (BOOL)xyd_isNextWeek;
- (BOOL)xyd_isLastWeek;

- (BOOL)xyd_isSameMonthAsDate: (NSDate *) aDate;
- (BOOL)xyd_isThisMonth;
- (BOOL)xyd_isNextMonth;
- (BOOL)xyd_isLastMonth;

- (BOOL)xyd_isSameYearAsDate: (NSDate *) aDate;
- (BOOL)xyd_isThisYear;
- (BOOL)xyd_isNextYear;
- (BOOL)xyd_isLastYear;

- (BOOL)xyd_isEarlierThanDate: (NSDate *) aDate;
- (BOOL)xyd_isLaterThanDate: (NSDate *) aDate;

- (BOOL)xyd_isInFuture;
- (BOOL)xyd_isInPast;

// Date roles
- (BOOL)xyd_isTypicallyWorkday;
- (BOOL)xyd_isTypicallyWeekend;

// Adjusting dates
- (NSDate *) xyd_dateByAddingYears: (NSInteger) dYears;
- (NSDate *) xyd_dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) xyd_dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) xyd_dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) xyd_dateByAddingDays: (NSInteger) dDays;
- (NSDate *) xyd_dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) xyd_dateByAddingHours: (NSInteger) dHours;
- (NSDate *) xyd_dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) xyd_dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) xyd_dateBySubtractingMinutes: (NSInteger) dMinutes;

// Date extremes
- (NSDate *) xyd_dateAtStartOfDay;
- (NSDate *) xyd_dateAtEndOfDay;

// Retrieving intervals
- (NSInteger) xyd_minutesAfterDate: (NSDate *) aDate;
- (NSInteger) xyd_minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) xyd_hoursAfterDate: (NSDate *) aDate;
- (NSInteger) xyd_hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) xyd_daysAfterDate: (NSDate *) aDate;
- (NSInteger) xyd_daysBeforeDate: (NSDate *) aDate;
- (NSInteger) xyd_distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger xyd_nearestHour;
@property (readonly) NSInteger xyd_hour;
@property (readonly) NSInteger xyd_minute;
@property (readonly) NSInteger xyd_seconds;
@property (readonly) NSInteger xyd_day;
@property (readonly) NSInteger xyd_month;
@property (readonly) NSInteger xyd_week;
@property (readonly) NSInteger xyd_weekday;
@property (readonly) NSInteger xyd_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger xyd_year;
@end
