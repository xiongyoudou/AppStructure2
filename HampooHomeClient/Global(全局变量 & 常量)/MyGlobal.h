//
//  MyGlobal.h
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/14.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#ifndef MyGlobal_h
#define MyGlobal_h

#pragma mark - 定义各类常用block块
typedef void (^IntegerResultBlock)(NSInteger number, NSError *error);
typedef void (^StringResultBlock)(NSString *string, NSError *error);
typedef void (^DictionaryResultBlock)(NSDictionary * dict, NSError *error);
typedef void (^ArrayResultBlock)(NSArray *objects, NSError *error);
typedef void (^SetResultBlock)(NSSet *channels, NSError *error);
typedef void (^DataResultBlock)(NSData *data, NSError *error);
typedef void (^StreamResultBlock)(NSInputStream * stream, NSError *error);
typedef void (^ImageResultBlock)(UIImage * image, NSError * error);
typedef void (^BoolResultBlock)(BOOL succeeded,NSError *error);
typedef void (^BoolObjResultBlock)(BOOL succeeded,id obj,NSError *error);

#endif /* MyGlobal_h */
