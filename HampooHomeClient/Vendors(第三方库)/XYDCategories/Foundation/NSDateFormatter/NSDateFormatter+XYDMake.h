//
//  NSDateFormatter+Make.h

//
//  Created by Jakey on 15/4/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  mobile.dzone.com/news/ios-threadsafe-date-formatting

#import <Foundation/Foundation.h>

@interface NSDateFormatter (XYDMake)
+(NSDateFormatter *)xyd_dateFormatterWithFormat:(NSString *)format;
+(NSDateFormatter *)xyd_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)xyd_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
+(NSDateFormatter *)xyd_dateFormatterWithDateStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)xyd_dateFormatterWithDateStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)xyd_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)xyd_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
@end
