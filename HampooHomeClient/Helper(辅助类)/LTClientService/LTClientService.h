//
//  LTClientService.h
//  LTClient
//
//  Created by Frank on 16/10/26.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LongTooth.h"
#import "NetworkServiceProtocol.h"

/** 获取用户信息服务 */
#define LTBOX_GETUSER_INFO_SERVICE @"ltbox_getuser_info_service"
/** 登录服务 */
#define LTBOX_LOGIN_SERVICE @"ltbox_login_service"
/** 回话服务 */
#define LTBOX_CHAT_SERVICE @"ltbox_chat_service"
/** 历史消息服务 */
#define LTBOX_HISTORY_MESSAGE_SERVICE @"ltbox_history_message_service"
/** 客户端接收消息 */
#define LT_CLIENT_RECEIVE_MESSAGE_SERVICE @"lt_client_receive_message_service"
/** 文件上传服务 */
#define LTBOX_FILE_UPLOAD_SERVICE @"ltbox_file_upload_service"
/** 文件下载服务 */
#define LTBOX_FILE_DOWNLOAD_SERVICE @"ltbox_file_download_service"

#define UI_LOGIN_SERVICE @"ui/login/service"
#define UI_CHAT_SERVICE @"ui_chat_service"

@protocol LTClientServiceDelegate <NSObject>
- (NSObject *)onRequest:(NSString *)context path:(NSString *)path params: (NSString *)params arguments:(NSMutableArray *)args;

@end

// 处理LongTooth的所有服务请求的封装，如初始化、登录、发送消息、上传、下载等
@interface LTClientService : NSObject<LongToothEventHandler,LongToothServiceRequestHandler,LongToothServiceResponseHandler,NetworkServiceProtocol>

@end
