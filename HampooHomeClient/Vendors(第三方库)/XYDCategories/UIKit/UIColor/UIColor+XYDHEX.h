//
//  UIColor+HEX.h

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XYDHEX)
+ (UIColor *)xyd_colorWithHex:(UInt32)hex;
+ (UIColor *)xyd_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)xyd_colorWithHexString:(NSString *)hexString;
- (NSString *)xyd_HEXString;

+ (UIColor *)xyd_colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha;

+ (UIColor *)xyd_colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue;
@end
