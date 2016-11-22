//
//  LTClientServiceHelper.h
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/14.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LTCilentUser;

@interface LTClientServiceHelper : NSObject

+ (NSArray <LTCilentUser *> *)dealWithLoginData:(NSData *)data;

@end
