//
//  NSObject+XYDisFirstLaunch.h
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/16.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>

//=========== how to use ===========================
//判断是否是第一次启动程序
//BOOL isFirstTimeOpening = [self xyd_isFirstLaunchToEvent:@"Run"
//                                           evenUpdate:YES
//                                          firstLaunch:^BOOL(){
//                                              //进行一系列操作比如网络请求等，等网络请求成功后，返回YES，网络请求失败后返回NO
//                                              return YES;
//                                          }];
//=========== then use like this ===========================
//  if(isFirstTimeOpening) {} else {}

typedef BOOL (^XYDFirstLaunchBlock)(void);

@interface NSObject (XYDisFirstLaunch)

/*!
 @brief 能判断出是否是【安装】或者【每次更新】后首次执行某个动作
 @details 适用场景比如，登陆、引导页面等等
 @param eventName 对于eventName 而言是第一次登陆
 @param evenUpdate 是否考虑更新的情况
 @param firstLaunch 只有LCCKFirstLaunchBlock的 return 返回值为 YES 的时候，本方法的返回值才是 YES。
 */
- (BOOL)xyd_isFirstLaunchToEvent:(NSString *)eventName
                       evenUpdate:(BOOL)evenUpdate
                      firstLaunch:(XYDFirstLaunchBlock)firstLaunch;

@end
