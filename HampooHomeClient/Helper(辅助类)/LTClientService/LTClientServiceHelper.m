//
//  LTClientServiceHelper.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/14.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "LTClientServiceHelper.h"
#import "LTCilentUser.h"

@implementation LTClientServiceHelper

+ (NSArray <LTCilentUser *> *)dealWithLoginData:(NSData *)data{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *array = [dict objectForKey:@"users"];
    if (!array)return nil;
    NSMutableArray *resultArr = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        NSDictionary *userDict = array[i];
        NSInteger userId = [[userDict objectForKey:@"id"] longValue];
        NSInteger userState = [[userDict objectForKey:@"state"] intValue];
        NSString *ltid = [userDict objectForKey:@"ltid"];
        NSString *nickName = [userDict objectForKey:@"nickName"];
        LTCilentUser *user = [[LTCilentUser alloc] initWithId:userId andLtid:ltid andNickName:nickName andState:userState];
        [resultArr addObject:user];
    }
    return  resultArr;
}

@end
