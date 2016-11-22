//
//  NetworkServiceProtocol.h
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/14.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>

// ”支撑APP网络服务“的框架所必须遵守的协议
@protocol NetworkServiceProtocol <NSObject>

// 初始化服务
- (BOOL)initService;
// 登录
- (void)logInWithPara:(NSDictionary *)paraDict resuleBlock:(BoolObjResultBlock)result;

@end
