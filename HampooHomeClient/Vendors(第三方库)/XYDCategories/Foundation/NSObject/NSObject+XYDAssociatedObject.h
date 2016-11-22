//
//  NSObject+XYDAssociatedObject.h

//
//  Created by Jakey on 14/12/11.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  定义一个dealloc时执行的对象
 *
 */
typedef void (^DeallocExecutorBlock)(void);

@interface XYDDeallocExecutor : NSObject

- (id)initWithBlock:(DeallocExecutorBlock)block;

@end;


@interface NSObject (XYDAssociatedObject)
/**
 *  @brief  附加一个stong对象
 *
 *  @param value 被附加的对象
 *  @param key   被附加对象的key
 */
- (void)xyd_associateValue:(id)value withKey:(const void *)key; // Strong reference
/**
 *  @brief  附加一个weak对象
 *
 *  @param value 被附加的对象
 *  @param key   被附加对象的key
 */
- (void)xyd_weaklyAssociateValue:(id)value withKey:(const void *)key;

/**
 *  @brief  根据附加对象的key取出附加对象
 *
 *  @param key 附加对象的key
 *
 *  @return 附加对象
 */
- (id)xyd_associatedValueForKey:(const void *)key;

- (void)xyd_executeAtDealloc:(DeallocExecutorBlock)block;

@end
