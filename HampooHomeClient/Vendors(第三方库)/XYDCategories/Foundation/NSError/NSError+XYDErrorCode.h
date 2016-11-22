//
//  NSError+XYDErrorCode.h
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/11.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kXYDErrorDomain;
extern NSString * const kXYDErrorUnknownText;

typedef NS_ENUM(NSInteger, XYDLocalErrorCode) {
    XYDLocalErrorCodeInvalidArgument = 10000
};

@interface NSError (XYDErrorCode)

+(NSError *)errorWithCode:(NSInteger)code;
+(NSError *)errorWithCode:(NSInteger)code errorText:(NSString *)text;
+ (NSError *)errorWithText:(NSString *)text;

+(NSError *)internalServerError;
+(NSError *)fileNotFoundError;
+(NSError *)dataNotAvailableError;

+ (NSError *)errorFromJSON:(id)JSON;
+ (NSString *)errorTextFromError:(NSError *)error;
+ (NSError *)errorFromAVError:(NSError *)error;


@end
