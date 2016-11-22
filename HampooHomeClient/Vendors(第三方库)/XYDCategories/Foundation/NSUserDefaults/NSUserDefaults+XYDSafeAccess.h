//
//  NSUserDefaults+SafeAccess.h

//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (XYDSafeAccess)
+ (NSString *)xyd_stringForKey:(NSString *)defaultName;

+ (NSArray *)xyd_arrayForKey:(NSString *)defaultName;

+ (NSDictionary *)xyd_dictionaryForKey:(NSString *)defaultName;

+ (NSData *)xyd_dataForKey:(NSString *)defaultName;

+ (NSArray *)xyd_stringArrayForKey:(NSString *)defaultName;

+ (NSInteger)xyd_integerForKey:(NSString *)defaultName;

+ (float)xyd_floatForKey:(NSString *)defaultName;

+ (double)xyd_doubleForKey:(NSString *)defaultName;

+ (BOOL)xyd_boolForKey:(NSString *)defaultName;

+ (NSURL *)xyd_URLForKey:(NSString *)defaultName;

#pragma mark - WRITE FOR STANDARD

+ (void)xyd_setObject:(id)value forKey:(NSString *)defaultName;

#pragma mark - READ ARCHIVE FOR STANDARD

+ (id)xyd_arcObjectForKey:(NSString *)defaultName;

#pragma mark - WRITE ARCHIVE FOR STANDARD

+ (void)xyd_setArcObject:(id)value forKey:(NSString *)defaultName;
@end
