//
//  NSString+XYDPinyin.m
//  Snowball
//
//  Created by croath on 11/11/13.
//  Copyright (c) 2013 Snowball. All rights reserved.
//

#import "NSString+XYDPinyin.h"

@implementation NSString (XYDPinyin)

- (NSString*)xyd_pinyinWithPhoneticSymbol{
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

- (NSString*)xyd_pinyin{
    NSMutableString *pinyin = [NSMutableString stringWithString:[self xyd_pinyinWithPhoneticSymbol]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

- (NSArray*)xyd_pinyinArray{
    NSArray *array = [[self xyd_pinyin] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return array;
}

- (NSString*)xyd_pinyinWithoutBlank{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (NSString *str in [self xyd_pinyinArray]) {
        [string appendString:str];
    }
    return string;
}

- (NSArray*)xyd_pinyinInitialsArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in [self xyd_pinyinArray]) {
        if ([str length] > 0) {
            [array addObject:[str substringToIndex:1]];
        }
    }
    return array;
}

- (NSString*)xyd_pinyinInitialsString{
    NSMutableString *pinyin = [NSMutableString stringWithString:@""];
    for (NSString *str in [self xyd_pinyinArray]) {
        if ([str length] > 0) {
            [pinyin appendString:[str substringToIndex:1]];
        }
    }
    return pinyin;
}

@end
