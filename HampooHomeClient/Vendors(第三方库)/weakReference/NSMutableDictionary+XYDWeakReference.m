//
//  NSMutableDictionary+XYDWeakReference.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/9.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "NSMutableDictionary+XYDWeakReference.h"
#import "XYDWeakReference.h"

@implementation NSMutableDictionary (XYDWeakReference)

- (void)xyd_weak_setObject:(id)anObject forKey:(NSString *)aKey {
    [self setObject:makeXYDWeakReference(anObject) forKey:aKey];
}

- (void)xyd_weak_setObjectWithDictionary:(NSDictionary *)dictionary {
    for (NSString *key in dictionary.allKeys) {
        [self setObject:makeXYDWeakReference(dictionary[key]) forKey:key];
    }
}

- (id)xyd_weak_getObjectForKey:(NSString *)key {
    return weakReferenceNonretainedObjectValue(self[key]);
}

@end
