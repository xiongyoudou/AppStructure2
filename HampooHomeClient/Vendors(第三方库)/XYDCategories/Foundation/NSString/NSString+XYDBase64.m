//
//  NSString+XYDBase64.m

//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSString+XYDBase64.h"
#import "NSData+XYDBase64.h"

@implementation NSString (Base64)
+ (NSString *)xyd_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData xyd_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (NSString *)xyd_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data xyd_base64EncodedStringWithWrapWidth:wrapWidth];
}
- (NSString *)xyd_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data xyd_base64EncodedString];
}
- (NSString *)xyd_base64DecodedString
{
    return [NSString xyd_stringWithBase64EncodedString:self];
}
- (NSData *)xyd_base64DecodedData
{
    return [NSData xyd_dataWithBase64EncodedString:self];
}
@end
