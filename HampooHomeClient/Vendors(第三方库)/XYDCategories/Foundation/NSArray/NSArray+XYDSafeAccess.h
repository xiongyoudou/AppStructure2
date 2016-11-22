//
//  NSArray+XYDSafeAccess.h

//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (XYDSafeAccess)
-(id)xyd_objectWithIndex:(NSUInteger)index;

- (NSString*)xyd_stringWithIndex:(NSUInteger)index;

- (NSNumber*)xyd_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)xyd_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)xyd_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)xyd_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)xyd_integerWithIndex:(NSUInteger)index;

- (NSUInteger)xyd_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)xyd_boolWithIndex:(NSUInteger)index;

- (int16_t)xyd_int16WithIndex:(NSUInteger)index;

- (int32_t)xyd_int32WithIndex:(NSUInteger)index;

- (int64_t)xyd_int64WithIndex:(NSUInteger)index;

- (char)xyd_charWithIndex:(NSUInteger)index;

- (short)xyd_shortWithIndex:(NSUInteger)index;

- (float)xyd_floatWithIndex:(NSUInteger)index;

- (double)xyd_doubleWithIndex:(NSUInteger)index;

- (NSDate *)xyd_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;
//CG
- (CGFloat)xyd_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)xyd_pointWithIndex:(NSUInteger)index;

- (CGSize)xyd_sizeWithIndex:(NSUInteger)index;

- (CGRect)xyd_rectWithIndex:(NSUInteger)index;
@end


#pragma --mark NSMutableArray setter

@interface NSMutableArray(XYDSafeAccess)

-(void)xyd_addObj:(id)i;

-(void)xyd_addString:(NSString*)i;

-(void)xyd_addBool:(BOOL)i;

-(void)xyd_addInt:(int)i;

-(void)xyd_addInteger:(NSInteger)i;

-(void)xyd_addUnsignedInteger:(NSUInteger)i;

-(void)xyd_addCGFloat:(CGFloat)f;

-(void)xyd_addChar:(char)c;

-(void)xyd_addFloat:(float)i;

-(void)xyd_addPoint:(CGPoint)o;

-(void)xyd_addSize:(CGSize)o;

-(void)xyd_addRect:(CGRect)o;
@end
