//
//  NSString+XYDPinyin.h
//  Snowball
//
//  Created by croath on 11/11/13.
//  Copyright (c) 2013 Snowball. All rights reserved.
//
// https://github.com/croath/NSString-Pinyin
//  the Chinese Pinyin string of the nsstring

#import <Foundation/Foundation.h>

@interface NSString (XYDPinyin)

- (NSString*)xyd_pinyinWithPhoneticSymbol;
- (NSString*)xyd_pinyin;
- (NSArray*)xyd_pinyinArray;
- (NSString*)xyd_pinyinWithoutBlank;
- (NSArray*)xyd_pinyinInitialsArray;
- (NSString*)xyd_pinyinInitialsString;

@end
