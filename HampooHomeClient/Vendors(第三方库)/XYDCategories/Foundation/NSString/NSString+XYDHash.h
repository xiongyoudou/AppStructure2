//
//  NSString+XYDHash.h

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (XYDHash)
@property (readonly) NSString *xyd_md5String;
@property (readonly) NSString *xyd_sha1String;
@property (readonly) NSString *xyd_sha256String;
@property (readonly) NSString *xyd_sha512String;

- (NSString *)xyd_hmacMD5StringWithKey:(NSString *)key;
- (NSString *)xyd_hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)xyd_hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)xyd_hmacSHA512StringWithKey:(NSString *)key;
@end
