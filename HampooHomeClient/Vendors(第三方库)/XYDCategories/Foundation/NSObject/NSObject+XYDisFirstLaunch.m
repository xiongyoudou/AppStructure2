//
//  NSObject+XYDisFirstLaunch.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/16.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "NSObject+XYDisFirstLaunch.h"

@implementation NSObject (XYDisFirstLaunch)

- (BOOL)xyd_isFirstLaunchToEvent:(NSString *)eventName
                       evenUpdate:(BOOL)evenUpdate
                      firstLaunch:(XYDFirstLaunchBlock)firstLaunch {
    BOOL isFirstLaunchAfterUpdateToEvent = NO;
    NSString *isAlreadyDoneEventKey;
    if (!evenUpdate) {
        isAlreadyDoneEventKey = [NSString stringWithFormat:@"isAlreadyDoneFor%@", eventName];
    } else {
        isAlreadyDoneEventKey = [NSString stringWithFormat:@"isAlreadyDoneFor%@InVersion%@", eventName, [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    }
    //check if has been done
    if (![[NSUserDefaults standardUserDefaults] valueForKey:isAlreadyDoneEventKey]) {
        //外部实现了block // block 返回YES，更新targetName操作成功
        if(firstLaunch && firstLaunch()) {
            // Set the value to YES
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
                [[NSUserDefaults standardUserDefaults] setValue:@YES forKey:isAlreadyDoneEventKey];
            });
            isFirstLaunchAfterUpdateToEvent = YES;
        }
    }
    //仅仅在firstLaunch()返回为ture时，返回YES。换句话讲：（不仅在非第一次启动时，返回NO，而且也在firstLaunch()不返回YES时也会返回NO）
    return isFirstLaunchAfterUpdateToEvent;
}


@end
