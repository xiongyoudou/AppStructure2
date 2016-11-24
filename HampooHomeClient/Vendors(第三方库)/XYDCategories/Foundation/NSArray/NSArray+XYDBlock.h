//
//  NSArray+Block.h

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XYDBlock)
- (void)xyd_each:(void (^)(id object))block;
- (void)xyd_eachWithIndex:(void (^)(id object, NSUInteger index))block;
- (NSArray *)xyd_map:(id (^)(id object))block;
- (NSArray *)xyd_filter:(BOOL (^)(id object))block;
- (NSArray *)xyd_reject:(BOOL (^)(id object))block;
- (id)xyd_detect:(BOOL (^)(id object))block;
- (id)xyd_reduce:(id (^)(id accumulator, id object))block;
- (id)xyd_reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block;
@end
