//
//  HttpTool.h
//  DotaMaster
//
//  Created by 世缘 on 15/4/9.
//  Copyright (c) 2015年 Qian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


/**
 https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Miscellaneous/Foundation_Constants/index.html#//apple_ref/doc/constant_group/URL_Loading_System_Error_Codes
 
 NSURLErrorUnknown = -1,
 NSURLErrorCancelled = -999,
 NSURLErrorBadURL = -1000,
 NSURLErrorTimedOut = -1001,
 NSURLErrorUnsupportedURL = -1002,
 NSURLErrorCannotFindHost = -1003,
 NSURLErrorCannotConnectToHost = -1004,
 NSURLErrorDataLengthExceedsMaximum = -1103,
 NSURLErrorNetworkConnectionLost = -1005,
 NSURLErrorDNSLookupFailed = -1006,
 NSURLErrorHTTPTooManyRedirects = -1007,
 NSURLErrorResourceUnavailable = -1008,
 NSURLErrorNotConnectedToInternet = -1009,
 NSURLErrorRedirectToNonExistentLocation = -1010,
 NSURLErrorBadServerResponse = -1011,
 NSURLErrorUserCancelledAuthentication = -1012,
 NSURLErrorUserAuthenticationRequired = -1013,
 NSURLErrorZeroByteResource = -1014,
 NSURLErrorCannotDecodeRawData = -1015,
 NSURLErrorCannotDecodeContentData = -1016,
 NSURLErrorCannotParseResponse = -1017,
 NSURLErrorInternationalRoamingOff = -1018,
 NSURLErrorCallIsActive = -1019,
 NSURLErrorDataNotAllowed = -1020,
 NSURLErrorRequestBodyStreamExhausted = -1021,
 NSURLErrorFileDoesNotExist = -1100,
 NSURLErrorFileIsDirectory = -1101,
 NSURLErrorNoPermissionsToReadFile = -1102,
 NSURLErrorSecureConnectionFailed = -1200,
 NSURLErrorServerCertificateHasBadDate = -1201,
 NSURLErrorServerCertificateUntrusted = -1202,
 NSURLErrorServerCertificateHasUnknownRoot = -1203,
 NSURLErrorServerCertificateNotYetValid = -1204,
 NSURLErrorClientCertificateRejected = -1205,
 NSURLErrorClientCertificateRequired = -1206,
 NSURLErrorCannotLoadFromNetwork = -2000,
 NSURLErrorCannotCreateFile = -3000,
 NSURLErrorCannotOpenFile = -3001,
 NSURLErrorCannotCloseFile = -3002,
 NSURLErrorCannotWriteToFile = -3003,
 NSURLErrorCannotRemoveFile = -3004,
 NSURLErrorCannotMoveFile = -3005,
 NSURLErrorDownloadDecodingFailedMidStream = -3006,
 NSURLErrorDownloadDecodingFailedToComplete = -3007
 */


/**
 *  使用须知：
 *  1、依赖AFNetworking第三方框架（测试bug：无法检测当前网络状态，需设置检测网络状态改变block检测完成才能返回正确状态）
 *  2、依赖Reachability第三方框架（检测当前网络状态）
 */

/** 网络类型枚举 */
typedef enum {
    NetworkStatusUnknow = -1,
    NetworkStatusNotReachable,  // 无网络连接
    NetworkStatusWiFi,              // Wifi
    NetworkStatusWWAN,              // WWAN
} NetWorkType;

@interface HttpTool : NSObject

/** 请求成功及失败的回调 */
typedef void (^HttpRequestSuccess) (id responseObject);
typedef void (^HttpRequestFailure) (NSError *error);
/** 网络状态改变通知监测回调message */
typedef void (^ReachabilityChangedBlock) (NSString * message);

+ (void)addNetworkStateChangedNotification;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params httpHeaderDict:(NSDictionary *)headerDict success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params httpHeaderDict:(NSDictionary *)headerDict success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

/**
 *  发送一个POST请求(上传图片数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param images  图片参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params images:(NSArray *)images success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params images:(NSArray *)images httpHeaderDict:(NSDictionary *)headerDict success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formDataArray  文件参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray httpHeaderDict:(NSDictionary *)headerDict success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse *__autoreleasing *)response error:(NSError *__autoreleasing *)error;

+ (AFHTTPSessionManager *)getHttpSessionManager:(NSDictionary *)httpHeaderDict;

+ (BOOL)isConnected;
+ (BOOL)isWIFI;
+ (BOOL)isWWAN;

@end


/** 用来封装上传的文件数据模型 */
@interface MyPostFromData : NSObject

/** 文件数据 */
@property (nonatomic, strong) NSData * data;
/** 参数名称 */
@property (nonatomic, copy) NSString * paramName;
/** 文件名 */
@property (nonatomic, copy) NSString * filename;
/** 文件类型---图片@"image/png" */
@property (nonatomic, copy) NSString * mimeType;

@end
