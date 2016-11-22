//
//  HttpTool.m
//  DotaMaster
//
//  Created by 世缘 on 15/4/9.
//  Copyright (c) 2015年 Qian. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool

static AFHTTPSessionManager *manager = nil;
static AFNetworkReachabilityStatus currentNetworkStatus = AFNetworkReachabilityStatusUnknown;

#pragma mark - 网络请求前处理，无网络不请求
+(BOOL)requestBeforeCheckNetWorkWithFailureBlock:(HttpRequestFailure)errorBlock{
    if(![self isConnected]){//无网络
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(errorBlock!=nil){
                errorBlock(nil);
                NSLog(@"无网络,请打开网络");
            }
        });
    }
    return [self isConnected];
}

#pragma mark - GET请求
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    [self getWithURL:url params:params httpHeaderDict:nil success:success failure:failure];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params httpHeaderDict:(NSDictionary *)headerDict success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    if (!url) {
        KMyLog(@"url为空");
        return;
    }
    if(![self requestBeforeCheckNetWorkWithFailureBlock:failure]){
        return;
    }
    //为url编码
    NSString *urlStr = [self urlCoding:url];
    // 2.发送请求
    [[self getHttpSessionManager:headerDict] GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        if (failure) {
            if ([url isEqualToString:@"http://192.168.5.183:9666/api/server/search"]) {
                KMyLog(@"dddddd");
            }
            NSLog(@"网络请求日志\n请求URL：%@ \n信息：%@",url,[error.userInfo objectForKey:@"NSLocalizedDescription"]);
            failure(error);
        }
    }];
}

#pragma mark - POST
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    [self postWithURL:url params:params httpHeaderDict:nil success:success failure:failure];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params httpHeaderDict:(NSDictionary *)headerDict success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    if (!url) {
        KMyLog(@"url为空");
        return;
    }
    if(![self requestBeforeCheckNetWorkWithFailureBlock:failure]){
        return;
    }
    //为url编码
    NSString *urlStr = [self urlCoding:url];
    // 2.发送请求
    [[self getHttpSessionManager:headerDict] POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        if (failure) {
            NSLog(@"网络请求日志\n请求URL：%@ \n信息：%@",url,[error.userInfo objectForKey:@"NSLocalizedDescription"]);
            failure(error);
        }
    }];

}


#pragma mark 上传图片
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params images:(NSArray *)images success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
        [self postWithURL:url params:params images:images httpHeaderDict:nil success:success failure:failure];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params images:(NSArray *)images httpHeaderDict:(NSDictionary *)headerDict success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    if (!url) {
        KMyLog(@"url为空");
        return;
    }
    if(![self requestBeforeCheckNetWorkWithFailureBlock:failure]){
        return;
    }
    //为url编码
    NSString *urlStr = [self urlCoding:url];
    // 2.发送请求
    [[self getHttpSessionManager:headerDict]POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage * image in images) {
            // 压缩
            NSData * imageData = UIImageJPEGRepresentation(image, 0.1); //UIImagePNGRepresentation(image);
            [formData appendPartWithFileData:imageData name:@"fileName.png" fileName:[NSString stringWithFormat:@"fileName.png"] mimeType:@"image/png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}


#pragma mark 上传文件数据
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    [self postWithURL:url params:params formDataArray:formDataArray httpHeaderDict:nil success:success failure:false];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray httpHeaderDict:(NSDictionary *)headerDict success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    if (!url) {
        KMyLog(@"url为空");
        return;
    }
    if(![self requestBeforeCheckNetWorkWithFailureBlock:failure]){
        return;
    }
    //为url编码
    NSString *urlStr = [self urlCoding:url];
    // 2.发送请求
    [[self getHttpSessionManager:headerDict]POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 拼接文件数据
        for (MyPostFromData *aFormData in formDataArray) {
            [formData appendPartWithFileData:aFormData.data name:aFormData.paramName fileName:aFormData.filename mimeType:aFormData.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - 通过request发送同步请求
+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse *__autoreleasing *)response error:(NSError *__autoreleasing *)error {
#if !TARGET_OS_WATCH
    return [NSURLConnection sendSynchronousRequest:request returningResponse:response error:error];
#else
    __block NSData *data = nil;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *taskData, NSURLResponse *taskResponse, NSError *taskError) {
        data = taskData;
        
        if (response)
            *response = taskResponse;
        
        if (error)
            *error = taskError;
        
        dispatch_semaphore_signal(semaphore);
    }] resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return data;
#endif
}


#pragma mark - 创建请求管理对象
+ (AFHTTPSessionManager *)getHttpSessionManager:(NSDictionary *)httpHeaderDict {
//    if (!manager) {
        manager = [AFHTTPSessionManager manager];
        //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 5.0;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
//    }
    //因为此处有设置HttpHeader，导致不能manager重用，否则会因为不支持Header而请求失败
    for (NSString *key in httpHeaderDict.allKeys) {
        [manager.requestSerializer setValue:httpHeaderDict[key] forHTTPHeaderField:key];
    }
    
    return manager;
}

#pragma mark - url编码
+ (NSString *)urlCoding:(NSString *)url{
    NSString *encodePath ;
    encodePath = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    return encodePath;
}

#pragma mark - 网络检测方法
+ (NetWorkType)networkConnectType {
    if ([self isWIFI]) {
        return NetworkStatusWiFi;
    }else if ([self isWWAN]){
        return NetworkStatusWWAN;
    }else {
        return NetworkStatusNotReachable;
    }
}

+ (BOOL)isWIFI {
    return [AFNetworkReachabilityManager sharedManager].isReachableViaWiFi;
}

+ (BOOL)isWWAN {
    return [AFNetworkReachabilityManager sharedManager].isReachableViaWWAN;
}

+ (BOOL)isConnected {
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

// 网络实时监测通知
+ (void)addNetworkStateChangedNotification {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    __block NSString * changedStated = nil;
    //根据回调信息判断网络类型
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (currentNetworkStatus != status) {
            [[NSNotificationCenter defaultCenter]postNotificationName:KNetworkStatusChangedNoti object:@{@"oldStatus":@(currentNetworkStatus),@"newStatus":@(status)}];
        }
        currentNetworkStatus = status;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                changedStated = @"未知的网络\n请检查网络设置";
//                KMyLog(@"stateChanged - > %@",changedStated);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                changedStated = @"当前没有网络连接\n请检查网络设置";
//                KMyLog(@"stateChanged - > %@",changedStated);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                changedStated = @"您当前使用的网络类型是WIFI";
//                KMyLog(@"stateChanged - > %@",changedStated);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                changedStated = @"您当前使用的是2G/3G网络\n可能会产生流量费用";
//                KMyLog(@"stateChanged - > %@",changedStated);
                break;
        }
    }];
}

@end

