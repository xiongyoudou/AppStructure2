//
//  NSSet+Block.h

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (XYDBlock)
- (void)xyd_each:(void (^)(id))block;
- (void)xyd_eachWithIndex:(void (^)(id, int))block;
- (NSArray *)xyd_map:(id (^)(id object))block;
- (NSArray *)xyd_select:(BOOL (^)(id object))block;
- (NSArray *)xyd_reject:(BOOL (^)(id object))block;
- (NSArray *)xyd_sort;
- (id)xyd_reduce:(id(^)(id accumulator, id object))block;
- (id)xyd_reduce:(id)initial withBlock:(id(^)(id accumulator, id object))block;
@end
