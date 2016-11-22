//
//  NSObject+XYDAppInfo.h
//  XYDCategories
//
//  Created by nidom on 15/9/29.
//  Copyright © 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XYDAppInfo)
-(NSString *)xyd_version;
-(NSInteger)xyd_build;
-(NSString *)xyd_identifier;
-(NSString *)xyd_currentLanguage;
-(NSString *)xyd_deviceModel;
@end
