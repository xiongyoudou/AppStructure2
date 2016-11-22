//
//  NSDate+Formatter.h

//
//  Copyright (C) 2013 by Christopher Meyer
//  http://schwiiz.org/
//

#import <Foundation/Foundation.h>

@interface NSDate (XYDFormatter)

+(NSDateFormatter *)xyd_formatter;
+(NSDateFormatter *)xyd_formatterWithoutTime;
+(NSDateFormatter *)xyd_formatterWithoutDate;

-(NSString *)xyd_formatWithUTCTimeZone;
-(NSString *)xyd_formatWithLocalTimeZone;
-(NSString *)xyd_formatWithTimeZoneOffset:(NSTimeInterval)offset;
-(NSString *)xyd_formatWithTimeZone:(NSTimeZone *)timezone;

-(NSString *)xyd_formatWithUTCTimeZoneWithoutTime;
-(NSString *)xyd_formatWithLocalTimeZoneWithoutTime;
-(NSString *)xyd_formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
-(NSString *)xyd_formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

-(NSString *)xyd_formatWithUTCWithoutDate;
-(NSString *)xyd_formatWithLocalTimeWithoutDate;
-(NSString *)xyd_formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
-(NSString *)xyd_formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)xyd_currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)xyd_dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)xyd_dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSString *)xyd_dateWithFormat:(NSString *)format;
@end
