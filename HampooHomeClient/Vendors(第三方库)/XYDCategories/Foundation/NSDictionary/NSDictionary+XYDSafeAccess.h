//
//  NSDictionary+XYDSafeAccess.h

//
//  Created by Jakey on 15/1/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (XYDSafeAccess)
- (BOOL)xyd_hasKey:(NSString *)key;

- (NSString*)xyd_stringForKey:(id)key;

- (NSNumber*)xyd_numberForKey:(id)key;

- (NSDecimalNumber *)xyd_decimalNumberForKey:(id)key;

- (NSArray*)xyd_arrayForKey:(id)key;

- (NSDictionary*)xyd_dictionaryForKey:(id)key;

- (NSInteger)xyd_integerForKey:(id)key;

- (NSUInteger)xyd_unsignedIntegerForKey:(id)key;

- (BOOL)xyd_boolForKey:(id)key;

- (int16_t)xyd_int16ForKey:(id)key;

- (int32_t)xyd_int32ForKey:(id)key;

- (int64_t)xyd_int64ForKey:(id)key;

- (char)xyd_charForKey:(id)key;

- (short)xyd_shortForKey:(id)key;

- (float)xyd_floatForKey:(id)key;

- (double)xyd_doubleForKey:(id)key;

- (long long)xyd_longLongForKey:(id)key;

- (unsigned long long)xyd_unsignedLongLongForKey:(id)key;

- (NSDate *)xyd_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)xyd_CGFloatForKey:(id)key;

- (CGPoint)xyd_pointForKey:(id)key;

- (CGSize)xyd_sizeForKey:(id)key;

- (CGRect)xyd_rectForKey:(id)key;
@end

#pragma --mark NSMutableDictionary setter

@interface NSMutableDictionary(SafeAccess)

-(void)xyd_setObj:(id)i forKey:(NSString*)key;

-(void)xyd_setString:(NSString*)i forKey:(NSString*)key;

-(void)xyd_setBool:(BOOL)i forKey:(NSString*)key;

-(void)xyd_setInt:(int)i forKey:(NSString*)key;

-(void)xyd_setInteger:(NSInteger)i forKey:(NSString*)key;

-(void)xyd_setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;

-(void)xyd_setCGFloat:(CGFloat)f forKey:(NSString*)key;

-(void)xyd_setChar:(char)c forKey:(NSString*)key;

-(void)xyd_setFloat:(float)i forKey:(NSString*)key;

-(void)xyd_setDouble:(double)i forKey:(NSString*)key;

-(void)xyd_setLongLong:(long long)i forKey:(NSString*)key;

-(void)xyd_setPoint:(CGPoint)o forKey:(NSString*)key;

-(void)xyd_setSize:(CGSize)o forKey:(NSString*)key;

-(void)xyd_setRect:(CGRect)o forKey:(NSString*)key;
@end
