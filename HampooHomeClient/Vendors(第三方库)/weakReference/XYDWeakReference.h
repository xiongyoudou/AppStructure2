//
//  XYDWeakReference.h
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/9.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^XYDWeakReference)(void);

XYDWeakReference makeXYDWeakReference(id object);

id weakReferenceNonretainedObjectValue(XYDWeakReference ref);

