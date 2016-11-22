//
//  LTClientService.m
//  LTClient
//
//  Created by Frank on 16/10/26.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "LTClientService.h"
#import "LTClientServiceHelper.h"

static NSString * const longToothKey = @"30820126300D06092A864886F70D010101050003820113003082010E028201023030384441414546374632343235413931453530463734323931444343344246433234333442333639333533303145344538454542334134323734434536354131433442393039393032373342324444433330323646393835393139413345334541393537354343333537393645304146324133343146353846363446314634353041333842383338323634433245314446413731303538453339343239383239424544464541453332433141314645313535463143463042363233373233463646464535353335323337363236313539313130423737413546364243464537343531343335344235374130384232414338363842433044333239373645304339330206303130303031";

@interface LTClientService () {
    BoolObjResultBlock _loginResultBlock;
}

@end

@implementation LTClientService

// 服务初始化,返回初始化结果
- (BOOL)initService {
    NSInteger devId = 194719942;
    NSInteger appId = 2;
    NSString *appkey = longToothKey;
    
    // 启动longTooth,handleEventBy指定“所有长牙事件”的处理回调对象,LongToothEventHandler为self
    [LongTooth start:devId withAppId:appId withAppKey:appkey handleEventBy:self];
    
    // 添加等待“外部服务请求”的服务（比如等待"其他人发送消息"的服务）,LongToothServiceRequestHandler为self
    [LongTooth addService:LT_CLIENT_RECEIVE_MESSAGE_SERVICE handleServiceRequestBy:self];
    return YES;
}

#pragma mark - 登录
- (void)logInWithPara:(NSDictionary *)paraDict resuleBlock:(BoolObjResultBlock)result {
    if(!paraDict) {
        result(NO,nil,[NSError errorWithText:@"参数为空"]);
        return;
    }
    _loginResultBlock = result;
    NSString *service_id = paraDict[@"service_id"];
    NSString *ltid = paraDict[@"ltid"];
    NSString *nickName = paraDict[@"nickName"];
    NSString *str = [NSString stringWithFormat:@"{\"nickName\":\"%@\",\"ltid\":\"%@\"}",nickName,ltid];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 发起登录请求，LongToothServiceResponseHandler为self
    [LongTooth request:service_id forService:LTBOX_LOGIN_SERVICE setDataType:LT_ARGUMENTS withArguments:data attach:nil handleServiceResponseBy:self];
}

#pragma mark - 发送消息请求



#pragma mark - LongToothEventHandler

/*
 * \brief摘要  LongTooth事件处理函数（处理开启服务之后的回调）
 * \param参数  event    长牙事件代码
 * \param     ltid     事件相关LongToothID
 * \param     service  事件相关LongTooth服务
 * \param     msg      事件相关信息
 * \param     attachment 事件相关附件，该附件在调用lt_request和lt_response时输入
 * \param     handle   附件处理函数
 */
- (void) handle:(NSInteger)event withLongToothId:(NSString*)ltid withServiceName:(NSString*)service withMessage:(NSData*)msg withAttachment:(id<LongToothAttachment>)attachment {
    if (event == EVENT_LONGTOOTH_STARTED) {
        // 启动服务
        
    }else {
        
    }
}

#pragma mark - LongToothServiceRequestHandler

/*
 * \brief摘要  LongTooth服务请求处理函数（处理添加服务之后的回调）
 * \param参数  ltt      服务请求方的长牙隧道
 * \param     ltid     服务请求方LongToothID
 * \param     service  请求LongTooth服务
 * \param     dataType 服务请求方的通讯方式
 * \param     args     服务请求方执行lt_request时输入的数组参数
 * \param     handle   附件处理函数
 */
- (void) handle:(id<LongToothTunnel>)ltt withLongToothId:(NSString*)ltid withServiceName:(NSString*)service dataTypeIs:(NSInteger)dataType withArguments:(NSData*)args {
    if ([service isEqualToString:LT_CLIENT_RECEIVE_MESSAGE_SERVICE]) {
        // 客户端接收消息
        
    }else {
    
    }
}


#pragma mark - LongToothServiceResponseHandler
/*
 * \brief摘要  LongTooth服务响应处理函数（处理针对不同服务发情请求之后的回调）
 * \param参数  ltt    服务提供者的长牙隧道
 * \param     ltid     服务提供者LongToothID
 * \param     service  请求的LongTooth服务
 * \param     dataType    服务提供者的通讯协议
 * \param     args      服务提供者执行request时输入的附件
 * \param     attachment 服务请求方执行response时输入的附件
 * \param     handle   附件处理函数
 */
- (void) handle:(id<LongToothTunnel>) ltt withLongToothId:(NSString*) ltid withServiceName:(NSString*) service dataTypeIs:(NSInteger) dataType withArguments:(NSData*) args attach:(id<LongToothAttachment>) attachment {
    if ([service isEqualToString:LTBOX_LOGIN_SERVICE]) {
        if (!_loginResultBlock)return;
        
        // 登录
        if (args == nil) {
            _loginResultBlock(NO,nil,[NSError errorWithText:@"返回数据为空"]);
            return ;
        }
        NSArray *userArr = [LTClientServiceHelper dealWithLoginData:args];
        _loginResultBlock(YES,userArr,nil);
    }else if ([service isEqualToString:LTBOX_CHAT_SERVICE]) {
        // 会话
        
    }else if ([service isEqualToString:LTBOX_HISTORY_MESSAGE_SERVICE]) {
        // 历史消息服务
        
    }else {
    
    }
}

#pragma mark - private methods
- (NSString *)getLongToothId {
    return [LongTooth getId];
}

@end
