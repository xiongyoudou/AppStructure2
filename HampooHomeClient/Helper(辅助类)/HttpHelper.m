//
//  HttpHelper.m
//  MiniPC
//
//  Created by xiongyoudou on 16/5/20.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "HttpHelper.h"
#import "AFNetworking.h"

@implementation HttpHelper

#pragma mark - 通用

/**
 *  判断请求是否成功
 *
 *  @param responseObject 服务器返回json
 *  @param isShow         如果请求失败，是否提示服务器返回的错误信息
 *
 *  @return 如果请求成功，将Data下面的数据返回，否则返回nil
 */
+ (id)isRequestSuccess:(id)responseObject showErrorTip:(BOOL)isShow {
    NSString *errorCode = [responseObject objectForKey:@"ErrorCode"];
    if ([errorCode isEqual:@200]) {
        id dataDict = [responseObject objectForKey:@"Data"];
        if(dataDict){
            return dataDict;
        }else {
            return @[];
        }
    }else {
        NSString *errorInfo;
        if([errorCode isEqual:@400]) {
            // 密码错误
            errorInfo = [responseObject objectForKey:@"Message"];
            
        }else{
            // 可能的其他错误
            errorInfo = [responseObject objectForKey:@"Message"];
        }
        
        if (isShow && errorInfo) {
            [MyTool dispatchMainQueueWithBlock:^{
                [[DialogTool sharedInstance]modifyTextOnTextHud:errorInfo andSuperView:KShowingView dismissAfterDelay:kHudDelay andWorkDone:nil];
            }];
        }
        return nil;
    }
}


@end
