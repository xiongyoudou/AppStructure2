//
//  NSData+SDDataCache.h
//  SDCycleScrollView
//
//  Created by aier on 15-3-30.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (XYDDataCache)

/**
 *  将URL作为key保存到磁盘里缓存起来
 *
 *  @param identifier url.absoluteString
 */
- (void)xyd_saveDataCacheWithIdentifier:(NSString *)identifier;

/**
 *  取出缓存data
 *
 *  @param identifier url.absoluteString
 *
 *  @return 缓存
 */
+ (NSData *)xyd_getDataCacheWithIdentifier:(NSString *)identifier;

@end
