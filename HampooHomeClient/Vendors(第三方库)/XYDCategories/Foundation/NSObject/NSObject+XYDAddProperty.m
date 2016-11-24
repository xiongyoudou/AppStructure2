//
//  NSObject+XYDAddProperty.m

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSObject+XYDAddProperty.h"
#import <objc/runtime.h>

//objc_getAssociatedObject和objc_setAssociatedObject都需要指定一个固定的地址，这个固定的地址值用来表示属性的key，起到一个常量的作用。
static const void *XYDStringProperty = &XYDStringProperty;
static const void *XYDIntegerProperty = &XYDIntegerProperty;
//static char IntegerProperty;
@implementation NSObject (XYDAddProperty)

@dynamic xyd_stringProperty;
@dynamic xyd_integerProperty;

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个字符串属性
 */
-(void)setXyd_stringProperty:(NSString *)xyd_stringProperty{
    //use that a static const as the key
    objc_setAssociatedObject(self, XYDStringProperty, xyd_stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //use that property's selector as the key:
    //objc_setAssociatedObject(self, @selector(stringProperty), stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//get
-(NSString *)xyd_stringProperty{
    return objc_getAssociatedObject(self, XYDStringProperty);
}

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个NSInteger属性
 */
-(void)setXyd_integerProperty:(NSInteger)xyd_integerProperty{
    NSNumber *number = [[NSNumber alloc]initWithInteger:xyd_integerProperty];
    objc_setAssociatedObject(self,XYDIntegerProperty, number, OBJC_ASSOCIATION_ASSIGN);
}
//get
-(NSInteger)xyd_integerProperty{
    return [objc_getAssociatedObject(self, XYDIntegerProperty) integerValue];
}

@end
