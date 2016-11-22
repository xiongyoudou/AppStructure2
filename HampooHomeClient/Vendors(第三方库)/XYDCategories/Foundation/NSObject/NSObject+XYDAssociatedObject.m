//
//  NSObject+XYDAssociatedObject.m

//
//  Created by Jakey on 14/12/11.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSObject+XYDAssociatedObject.h"
#import  <objc/runtime.h>

@interface XYDDeallocExecutor ()

@property (nonatomic, copy) DeallocExecutorBlock deallocExecutorBlock;

@end

@implementation XYDDeallocExecutor

- (id)initWithBlock:(DeallocExecutorBlock)deallocExecutorBlock {
    self = [super init];
    if (self) {
        _deallocExecutorBlock = [deallocExecutorBlock copy];
    }
    return self;
}

- (void)dealloc {
    _deallocExecutorBlock ? _deallocExecutorBlock() : nil;
}

@end



@implementation NSObject (XYDAssociatedObject)
/**
 *  @brief  附加一个stong对象
 *
 *  @param value 被附加的对象
 *  @param key   被附加对象的key
 */
- (void)xyd_associateValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}
/**
 *  @brief  附加一个weak对象
 *
 *  @param value 被附加的对象
 *  @param key   被附加对象的key
 */
- (void)xyd_weaklyAssociateValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}
/**
 *  @brief  根据附加对象的key取出附加对象
 *
 *  @param key 附加对象的key
 *
 *  @return 附加对象
 */
- (id)xyd_associatedValueForKey:(const void *)key {
    return objc_getAssociatedObject(self, key);
}

// 通过绑定，使得dealloc时执行特定的方法
const void * deallocExecutorBlockKey = &deallocExecutorBlockKey;
- (void)xyd_executeAtDealloc:(DeallocExecutorBlock)block {
    if (block) {
        XYDDeallocExecutor *executor = [[XYDDeallocExecutor alloc] initWithBlock:block];
        objc_setAssociatedObject(self,
                                 deallocExecutorBlockKey,
                                 executor,
                                 OBJC_ASSOCIATION_RETAIN);
    }
}

@end

