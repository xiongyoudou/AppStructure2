//
//  NSBundle+XYDAppIcon.h

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSBundle (XYDExtionsion)
- (NSString*)xyd_appIconPath ;
- (UIImage*)xyd_appIcon ;
+ (NSString *)xyd_bundlePathForBundleName:(NSString *)bundleName class:(Class)aClass;
+ (NSBundle *)xyd_bundleForName:(NSString *)bundleName class:(Class)aClass;
@end
