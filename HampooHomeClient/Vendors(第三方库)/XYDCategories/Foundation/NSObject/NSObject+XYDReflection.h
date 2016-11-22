//
//  NSObject+XYDReflection.h
//  NSObject-JKReflection
//
//  Created by Jakey on 15/12/22.
//  Copyright © 2015年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XYDReflection)
//类名
- (NSString *)xyd_className;
+ (NSString *)xyd_className;
//父类名称
- (NSString *)xyd_superClassName;
+ (NSString *)xyd_superClassName;

//实例属性字典
-(NSDictionary *)xyd_propertyDictionary;

//属性名称列表
- (NSArray*)xyd_propertyKeys;
+ (NSArray *)xyd_propertyKeys;

//属性详细信息列表
- (NSArray *)xyd_propertiesInfo;
+ (NSArray *)xyd_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)xyd_propertiesWithCodeFormat;

//方法列表
-(NSArray*)xyd_methodList;
+(NSArray*)xyd_methodList;

-(NSArray*)xyd_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)xyd_registedClassList;
//实例变量
+ (NSArray *)xyd_instanceVariable;

//协议列表
-(NSDictionary *)xyd_protocolList;
+ (NSDictionary *)xyd_protocolList;


- (BOOL)xyd_hasPropertyForKey:(NSString*)key;
- (BOOL)xyd_hasIvarForKey:(NSString*)key;

@end
