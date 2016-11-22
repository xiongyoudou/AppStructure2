//
//  HttpConstant.h
//  MiniPC
//
//  Created by xiongyoudou on 16/4/27.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpConstant : NSObject

// 连接上设备之后，通过该基地址发起请求，在程序启动时，通过其他存储在本地的数据获得
extern NSString *requestBaseUrl;

@end
