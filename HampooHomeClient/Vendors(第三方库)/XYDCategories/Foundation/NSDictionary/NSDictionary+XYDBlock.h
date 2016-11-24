//
//  NSDictionary+XYDBlock.h

//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XYDBlock)

#pragma mark - RX
- (void)xyd_each:(void (^)(id k, id v))block;
- (void)xyd_eachKey:(void (^)(id k))block;
- (void)xyd_eachValue:(void (^)(id v))block;
- (NSArray *)xyd_map:(id (^)(id key, id value))block;
- (NSDictionary *)xyd_pick:(NSArray *)keys;
- (NSDictionary *)xyd_omit:(NSArray *)key;

@end
