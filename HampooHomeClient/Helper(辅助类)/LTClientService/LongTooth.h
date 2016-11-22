//
//  LongTooth.h
//  lt3-objc-lib
//
//  Created by Robin Shang on 15/11/5.
//  Copyright (c) 2015年 Robin Shang. All rights reserved.
//
#import <Foundation/Foundation.h>
#define EVENT_LONGTOOTH_STOPPED             0x20000
/*
 *长牙启动
 */
#define EVENT_LONGTOOTH_STARTED             0x20001
#define EVENT_LONGTOOTH_KEEPALIVE           0x20004
#define EVENT_LONGTOOTH_KEEPALIVE_ACK       0x20005
#define EVENT_LONGTOOTH_KEEPALIVE_FAILED    0x20006

#define EVENT_LONGTOOTH_INVALID             0x28001
#define EVENT_LONGTOOTH_TIMEOUT             0x28002

/*b
 *目标长牙ID无法访问
 */
#define EVENT_LONGTOOTH_UNREACHABLE         0x28003

/*
 *目标长牙ID不在线
 */
#define EVENT_LONGTOOTH_OFFLINE             0x28004
#define EVENT_LONGTOOTH_BROADCAST           0x28005

/*
 *目标长牙应用的服务不存在
 */
#define EVENT_SERVICE_NOT_EXIST             0x40001
#define EVENT_SERVICE_INVALID               0x40002
#define EVENT_SERVICE_EXCEPTION             0x40003
#define EVENT_SERVICE_TIMEOUT               0x40004

/*
 *长牙隧道仅使用数组参数通讯
 */

#define LT_ARGUMENTS	0
/*
 *长牙隧道使用数组参数和数据报文方式通讯
 */
#define LT_STREAM		1 
/*
 *长牙隧道使用数组参数和数据报文方式通讯
 */
#define LT_DATAGRAM		2



/*LongToothTunnel协议名
 *协议里面有两个必须实现的方法
 *接收数据和发送数据
 *
 */
@protocol LongToothTunnel

@required
//-(NSInteger) receive:(char*) buffer lengthIs:(NSInteger) length;
/*
 *接收数据
 */
-(NSInteger) receive:(NSMutableData*) data;
@required
//-(NSInteger) send:(const char*) buffer lengthIs:(NSInteger) length;
/*
 *发送数据
 */
-(NSInteger) send:(NSData*) data;
@end

@protocol LongToothAttachment
@required
-(NSObject*) handle:(NSObject*) arg;
@end

@protocol LongToothEventHandler
/*
 * \brief摘要  LongTooth事件处理函数
 * \param参数  event    长牙事件代码
 * \param     ltid     事件相关LongToothID
 * \param     service  事件相关LongTooth服务
 * \param     msg      事件相关信息
 * \param     attachment 事件相关附件，该附件在调用lt_request和lt_response时输入
 * \param     handle   附件处理函数
 */


@required
-(void) handle:(NSInteger) event withLongToothId:(NSString*) ltid withServiceName:(NSString*) service withMessage:(NSData*) msg withAttachment:(id<LongToothAttachment>) attachment;

@end

@protocol LongToothServiceRequestHandler
/*
 * \brief摘要  LongTooth服务请求处理函数
 * \param参数  ltt      服务请求方的长牙隧道
 * \param     ltid     服务请求方LongToothID
 * \param     service  请求LongTooth服务
 * \param     dataType 服务请求方的通讯方式
 * \param     args     服务请求方执行lt_request时输入的数组参数
 * \param     handle   附件处理函数
 */
@required
-(void) handle:(id<LongToothTunnel>) ltt withLongToothId:(NSString*) ltid withServiceName:(NSString*) service dataTypeIs:(NSInteger) dataType withArguments:(NSData*) args;
@end


@protocol LongToothServiceResponseHandler
/*
 * \brief摘要  LongTooth服务响应处理函数
 * \param参数  ltt    服务提供者的长牙隧道
 * \param     ltid     服务提供者LongToothID
 * \param     service  请求的LongTooth服务
 * \param     dataType    服务提供者的通讯协议
 * \param     args      服务提供者执行request时输入的附件
 * \param     attachment 服务请求方执行response时输入的附件
 * \param     handle   附件处理函数
 */
@required
-(void) handle:(id<LongToothTunnel>) ltt withLongToothId:(NSString*) ltid withServiceName:(NSString*) service dataTypeIs:(NSInteger) dataType withArguments:(NSData*) args attach:(id<LongToothAttachment>) attachment;
@end


@interface LongTooth: NSObject

/*
 * \brief摘要  设置长牙注册服务器，设置网络环境
 * \param参数  host    长牙注册服务器地址
 * \param     port     长牙注册服务器端口
 */
+(void) setRegisterHost:(NSString*) host andPort:(NSUInteger) port;

/*
 * \brief摘要  获取本段LongToothID
 * \@return  本端LongToothID字符串
 */
+(NSString*) getId;

/*
 * \brief摘要  添加长牙服务，等待外部服务请求
 * \param参数  service  长牙服务名，不能为空
 * \param     handler  长牙服务请求处理函数，不能为空
 */
+(void) addService:(NSString*) service handleServiceRequestBy:(id<LongToothServiceRequestHandler>) handler;

/*
 * \brief摘要  长牙启动
 * \param参数  devID    长牙开发者ID
 * \param     appID    长牙应用ID
 * \param     appKey   长牙应用公钥
 * \param     handler  长牙事件处理函数
 * \return 0,启动成功; return -1,启动失败
 */
+(NSInteger) start:(NSInteger) devId withAppId:(NSInteger) appId withAppKey:(NSString*) appKey handleEventBy:(id<LongToothEventHandler>) handler;

/*
 * \brief摘要  长牙服务请求函数
 * \param参数  ltid    服务请求方LongToothID
 * \param     dataType   服务请求长牙隧道通讯方式
 * \param     args       服务请求数组参数
 * \param     attachment 服务请求附件，在lt_service_response_handler和lt_event_handler中使用
 * \param     handler    服务请求附件处理函数，不能为null
 * \@return 0 ,长牙服务请求执行，-1，未执行
 */
+(id<LongToothTunnel>) request:(NSString*) ltid forService:(NSString*) service setDataType:(NSInteger) dataType withArguments:(NSData*) args attach:(id<LongToothAttachment>) attachment handleServiceResponseBy:(id<LongToothServiceResponseHandler>) handler;

/*
 * \brief摘要  长牙服务响应函数
 * \param参数  ltt    服务请求者的长牙隧道，不能为null
 * \param     dataType   响应服务请求通讯方式
 * \param     args       服务响应数组参数
 * \param     attachment 服务响应附件，在lt_event_handler中使用
 * \param     handler    服务响应附件处理函数，不能为null
 * \@return 0 ,长牙服务请求执行，-1，未执行
 */
+(NSInteger) respond:(id<LongToothTunnel>)ltt setDataType:(NSInteger) dataType withArguments:(NSData*) args attach:(id<LongToothAttachment>) attachment;
/*
 *brief摘要   长牙广播
 *param参数   keyword
 *param      msg
 */

+(NSInteger) broadcast:(NSString*) keyword withMessage:(NSData*) msg;

@end
