//
//  NSData+XYDHash.h

//
//  Created by Jakey on 15/6/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (XYDHash)
/**
 *  @brief  md5 NSData
 */
@property (readonly) NSData *xyd_md5Data;
/**
 *  @brief  sha1Data NSData
 */
@property (readonly) NSData *xyd_sha1Data;
/**
 *  @brief  sha256Data NSData
 */
@property (readonly) NSData *xyd_sha256Data;
/**
 *  @brief  sha512Data NSData
 */
@property (readonly) NSData *xyd_sha512Data;

/**
 *  @brief  md5 NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)xyd_hmacMD5DataWithKey:(NSData *)key;
/**
 *  @brief  sha1Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)xyd_hmacSHA1DataWithKey:(NSData *)key;
/**
 *  @brief  sha256Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)xyd_hmacSHA256DataWithKey:(NSData *)key;
/**
 *  @brief  sha512Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)xyd_hmacSHA512DataWithKey:(NSData *)key;
@end
