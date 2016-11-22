//
//  NSBundle+XYDAppIcon.m

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSBundle+XYDExtionsion.h"

@implementation NSBundle (XYDExtionsion)
- (NSString*)xyd_appIconPath {
    NSString* iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"] ;
    NSString* iconBasename = [iconFilename stringByDeletingPathExtension] ;
    NSString* iconExtension = [iconFilename pathExtension] ;
    return [[NSBundle mainBundle] pathForResource:iconBasename
                                           ofType:iconExtension] ;
}

- (UIImage*)xyd_appIcon {
    UIImage*appIcon = [[UIImage alloc] initWithContentsOfFile:[self xyd_appIconPath]] ;
    return appIcon;
}


+ (NSString *)xyd_bundlePathForBundleName:(NSString *)bundleName class:(Class)aClass {
    NSString *pathComponent = [NSString stringWithFormat:@"%@.bundle", bundleName];
    NSString *bundlePath =[[[NSBundle bundleForClass:aClass] resourcePath] stringByAppendingPathComponent:pathComponent];
    return bundlePath;
}

+ (NSBundle *)xyd_bundleForName:(NSString *)bundleName class:(Class)aClass {
    NSString *bundlePath = [NSBundle xyd_bundlePathForBundleName:bundleName class:aClass];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return bundle;
}

@end
