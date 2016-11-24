//
//  NSMutableDictionary+XYDWeakReference.h
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/9.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (XYDWeakReference)

- (void)xyd_weak_setObject:(id)anObject forKey:(NSString *)aKey;

- (void)xyd_weak_setObjectWithDictionary:(NSDictionary *)dic;

- (id)xyd_weak_getObjectForKey:(NSString *)key;

@end
