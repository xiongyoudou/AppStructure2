//
//  NSString+XYDBase64.h

//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XYDBase64)
+ (NSString *)xyd_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)xyd_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)xyd_base64EncodedString;
- (NSString *)xyd_base64DecodedString;
- (NSData *)xyd_base64DecodedData;
@end
