//
//  XYDWeakReference.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/9.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "XYDWeakReference.h"

XYDWeakReference makeXYDWeakReference(id object) {
    __weak id weakref = object;
    return ^{
        return weakref;
    };
}

id weakReferenceNonretainedObjectValue(XYDWeakReference ref) {
    return ref ? ref() : nil;
}
