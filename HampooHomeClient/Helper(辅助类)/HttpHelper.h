//
//  HttpHelper.h
//  MiniPC
//
//  Created by xiongyoudou on 16/5/20.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpTool.h"

@interface HttpHelper : NSObject
+ (id)isRequestSuccess:(id)responseObject showErrorTip:(BOOL)isShow;
@end
