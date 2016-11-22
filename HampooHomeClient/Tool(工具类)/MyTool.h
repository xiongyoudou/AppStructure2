//
//  MyTool.h
//  ShopApp
//
//  Created by xiong有都 on 15/11/1.
//  Copyright © 2015年 xiong有都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

/**
 *  与特定程序无关的工具方法
 */

@interface MyTool : NSObject


#pragma mark - 视图相关
+ (UITableView *)createTableViewWithStyle:(UITableViewStyle)style onCtrl:( UIViewController <UITableViewDelegate,UITableViewDataSource> *)ctrl;
+ (void)registeCellWithCellXib:(NSString *)XIBName andTable:(UITableView *)table;
// 隐藏tableview多余的分割线
+ (void)hideExtraTableviewSeparatedLine:(UITableView *)tableview;
/**
 *  根据xib的名称获取xib中的视图对象
 */
+ (UIView *)getNibViewByNibName:(NSString *)nibName;
// 设置serchBar背景
+ (void)customSearchBar:(UISearchBar *)searchBar;
// 获取当前正显示的视图控制器
+ (UIViewController *)getShowingViewingCtrl;
// 获取当前活跃控制器方法2
+ (UIViewController *)activityViewController;
+ (UIViewController *)getRealCurrentViewCtrl:(UIViewController *)ctrl;

#pragma mark - 处理按钮验证码倒计时
+ (void)countDownAfterClick:(UIButton *)btn countDownSeconds:(int)seconds;
+ (void)getRemainingTime:(NSTimer *)timer;


#pragma mark - 线程
+ (void)dispatchQueueWithBlock:(void(^)())dealBlock;
+ (void)dispatchMainQueueWithBlock:(void(^)())dealBlock;
+ (void)dispatchQueueWithBlock:(void(^)())dealBlock aterBlockOnMainQueue:(void(^)())afterBlock;

#pragma mark - 字符串操作

// 对字符串进行“指定的字符后面的所有字符”的删除操作，获取指定字符串前一部分
+ (NSString *)getFrontStrOn:(NSString *)originStr byDeleteStr:(NSString *)deleteStr;
// 对字符串进行“指定的字符前面的所有字符”的删除操作，获取指定字符串后一部分
+ (NSString *)getRearStrOn:(NSString *)originStr byDeleteStr:(NSString *)deleteStr;
// 对中文进行编码，返回编码后的字符串
+ (NSString *)encodeWithChineseStr:(NSString *)str;
// 对已编码的中文字符串进行解码，返回正常中文字符串
+ (NSString *)decodeWithChineseStr:(NSString *)str;
// 去掉首位两端空格
+(NSString *)clearSpaceOnSides:(NSString *)str;
// 对服务器返回的时间类型字符串去掉T,替换成空格
+(NSString *)dealWithServerTimeStr:(NSString *)str;
// 对字符串中的特定字符串进行替换
+(NSString *)replaceStr:(NSString *)placedStr withStr:(NSString *)withStr onTotalStr:(NSString *)totalStr;
// 不区分大小写，判断两个字符串是否相同
+ (BOOL)isEqualCaseInsensitive:(NSString *)str1 withStr:(NSString *)str2;
// 判断字符串是否是无效的字符串
+ (NSString *)isValidString:(NSString *)str;

#pragma mark - 读取设备特定功能的访问权限
+ (BOOL)isCameraDenied;
+ (BOOL)isPhotoDenied;
+ (BOOL)isMicroPhoneDenied;
+ (BOOL)isMobileContractsDenied;
+ (BOOL)isLocationDenied;

#pragma mark - 多用户登录时，根据特定格式保存用户数据
+ (id)getUserDefaultWithKey:(NSString *)key onUser:(NSString *)userId;
// 注意：此处我设置了存入的数据必须是对象类型，即使打算存入的是bool，int，也将其转换成NSNumber
+ (void)setUserDefaultWithKey:(NSString *)key onUser:(NSString *)userId value:(id)value;
+ (void)clearUserDefaultWithKey:(NSString *)key onUser:(NSString *)userId;

#pragma mark - KeyChain保存UUID
// 设置uuid，并通过keyChain保存
+ (NSString *)setKeyChainValueWithBundleId:(NSString *)bundleId;
// 从keyChain中取出uuid
+ (NSString *)getKeyChainValueWithBundleId:(NSString *)bundleId;

#pragma mark - 其他方法

// 对象是否有效
+ (id)isValidObj:(id)obj;
+ (NSArray *)getScaleArray;
+ (void)warnMainThreadIfNecessary;
+(void)performSelectorIfCould:(id)target
                     selector:(SEL)selector
                       object:(id)arg1
                       object:(id)arg2;

@end
