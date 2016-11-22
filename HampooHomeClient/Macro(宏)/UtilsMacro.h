//
//  UtilsMacro.h
//  MiniPC
//
//  Created by xiongyoudou on 16/4/27.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

// 1.判断是否为4英寸
#define KMyIs4_inch ([UIScreen mainScreen].bounds.size.height == 568)

// 2.判断系统版本是否大于7.0/8.0,设备型号
#define KCurrentSyetemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define KMyIsiOS7OrLater ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define KMyIsiOS8OrLater ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)


#if TARGET_IPHONE_SIMULATOR
#define KSIMULATOR 1
#elif TARGET_OS_IPHONE
#define KSIMULATOR 0
#endif
#define KIS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define KIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define KIS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define KIS_IPHONE_4_OR_LESS (KIS_IPHONE && KWindowSize.height < 568.0)
#define KIS_IPHONE_5 (KIS_IPHONE && KWindowSize.height == 568.0)
#define KIS_IPHONE_6 (KIS_IPHONE && KWindowSize.height == 667.0)
#define KIS_IPHONE_6P (KIS_IPHONE && KWindowSize.height == 736.0)

#define KWindow [[UIApplication sharedApplication].delegate window]
#define KWindowSize KWindow.bounds.size

#define KShowingViewCtrl [MyTool getShowingViewingCtrl]
#define KShowingView KShowingViewCtrl.view

// 3.颜色---可设置alpha
#define COLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// 4.自定义log---发布打包自动去掉注释
#ifdef DEBUG        // 调试
#define KMyLog(fmt, ...) {NSLog((@"%s [Line %d] DEBUG:--->" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#else               // 发布打包
#define KMyLog(...)
#endif

// 5.自定义tabBar的高度
#define kMyStatusBarHeight 20.0f
#define kMyNavigationBarHeight 44.0f
#define kMyTopBarHeight 64.0f
#define kMyButtomBarHeight 49.0f

/** 提示框消失延时默认的时间 */
#define kHudDelay 1.0
#define kHudDelayShort 0.6

// 6.屏幕宽高
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

// 7.数据存储
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kDocumentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define kCachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define kTempPath NSTemporaryDirectory()

// 8.App和AppDelegate
#define KAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define KApplication (UIApplication *)[UIApplication sharedApplication]

// 功能区
// image STRETCH
#define STRETCH_IMAGE(image, edgeInsets) [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch]
#define KMax(a,b) (a)>(b)?(a):(b);

// 正则表达式
#define URLRegularString @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"                                                //匹配url正则表达式
#define PHONERegularString @"\\d{3}-\\d{7}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{8}|1+[358]+\\d{9}|\\d{8}|\\d{7}$"//匹配电话号码
#define EMAILRegularString @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*.\\w+([-.]\\w+)*"//匹配邮箱
#define EMOJIRegularString @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]"//匹配表情

// 弱引用--block常使用
#define WEAKSELF typeof(self) __weak weakSelf = self;

#endif /* UtilsMacro_h */
