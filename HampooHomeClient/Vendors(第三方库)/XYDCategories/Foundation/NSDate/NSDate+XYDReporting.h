//
// NSDate+Reporting.h
//
// Created by Mel Sampat on 5/11/12.
// Copyright (c) 2012 Mel Sampat.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDate (XYDReporting)

// Return a date with a specified year, month and day.
+ (NSDate *)xyd_dateWithYear:(int)year month:(int)month day:(int)day;

// Return midnight on the specified date.
+ (NSDate *)xyd_midnightOfDate:(NSDate *)date;

// Return midnight today.
+ (NSDate *)xyd_midnightToday;

// Return midnight tomorrow.
+ (NSDate *)xyd_midnightTomorrow;

// Returns a date that is exactly 1 day after the specified date. Does *not*
// zero out the time components. For example, if the specified date is
// April 15 2012 10:00 AM, the return value will be April 16 2012 10:00 AM.
+ (NSDate *)xyd_oneDayAfter:(NSDate *)date;

// Returns midnight of the first day of the current, previous or next Month.
// Note: firstDayOfNextMonth returns midnight of the first day of next month,
// which is effectively the same as the "last moment" of the current month.
+ (NSDate *)xyd_firstDayOfCurrentMonth;
+ (NSDate *)xyd_firstDayOfPreviousMonth;
+ (NSDate *)xyd_firstDayOfNextMonth;

// Returns midnight of the first day of the current, previous or next Quarter.
// Note: firstDayOfNextQuarter returns midnight of the first day of next quarter,
// which is effectively the same as the "last moment" of the current quarter.
+ (NSDate *)xyd_firstDayOfCurrentQuarter;
+ (NSDate *)xyd_firstDayOfPreviousQuarter;
+ (NSDate *)xyd_firstDayOfNextQuarter;

// Returns midnight of the first day of the current, previous or next Year.
// Note: firstDayOfNextYear returns midnight of the first day of next year,
// which is effectively the same as the "last moment" of the current year.
+ (NSDate *)xyd_firstDayOfCurrentYear;
+ (NSDate *)xyd_firstDayOfPreviousYear;
+ (NSDate *)xyd_firstDayOfNextYear;


- (NSDate*)xyd_dateFloor;
- (NSDate*)xyd_dateCeil;

- (NSDate*)xyd_startOfWeek;
- (NSDate*)xyd_endOfWeek;

- (NSDate*) xyd_startOfMonth;
- (NSDate*) xyd_endOfMonth;

- (NSDate*) xyd_startOfYear;
- (NSDate*) xyd_endOfYear;

- (NSDate*) xyd_previousDay;
- (NSDate*) xyd_nextDay;

- (NSDate*) xyd_previousWeek;
- (NSDate*) xyd_nextWeek;

- (NSDate*) xyd_previousMonth;
- (NSDate*) xyd_previousMonth:(NSUInteger) monthsToMove;
- (NSDate*) xyd_nextMonth;
- (NSDate*) xyd_nextMonth:(NSUInteger) monthsToMove;

#ifdef DEBUG
// For testing only. A helper function to format and display a date
// with an optional comment. For example:
//     NSDate *test = [NSDate firstDayOfCurrentMonth];
//     [test logWithComment:@"First day of current month: "];
- (void)xyd_logWithComment:(NSString *)comment;
#endif

@end
