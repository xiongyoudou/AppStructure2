//
//  MyTool.m
//  ShopApp
//
//  Created by xiong有都 on 15/11/1.
//  Copyright © 2015年 xiong有都. All rights reserved.
//

#import "MyTool.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <AddressBook/AddressBook.h>
#import <CoreLocation/CoreLocation.h>

#import "SSKeychain.h"

@implementation MyTool

#pragma mark - 视图相关

/**
 *  创建tableView
 *
 *  @param style cell的XIB名字
 *  @param ctrl  tableView所在的控制器
 *  @return 返回创建的tableView
 */
+ (UITableView *)createTableViewWithStyle:(UITableViewStyle)style onCtrl:( UIViewController <UITableViewDelegate,UITableViewDataSource> *)ctrl {
    UITableView *tableView = [[UITableView alloc] initWithFrame:ctrl.view.bounds style:style];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (style == UITableViewStyleGrouped) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:tableView.bounds];
        backgroundView.backgroundColor = tableView.backgroundColor;
        tableView.backgroundView = backgroundView;
    }
    tableView.delegate = ctrl;
    tableView.dataSource = ctrl;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [ctrl.view addSubview:tableView];
    return tableView;
}

/**
 *  给tableView注册cell
 *
 *  @param XIBName cell的XIB名字
 *  @param table   tableview
 */
+ (void)registeCellWithCellXib:(NSString *)XIBName andTable:(UITableView *)table {
    [table registerNib:[UINib nibWithNibName:XIBName bundle:nil] forCellReuseIdentifier:XIBName];
}

// 隐藏tableview多余的分割线
+ (void)hideExtraTableviewSeparatedLine:(UITableView *)tableview {
    tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的分割线
}

/**
 *  根据xib的名称获取xib中的视图对象
 */
+ (UIView *)getNibViewByNibName:(NSString *)nibName {
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    UIView *nibView = (UIView *)arrayOfViews[0];
    return nibView;
}


// 设置serchBar背景
+ (void)customSearchBar:(UISearchBar *)searchBar{
    [[[[searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
    [searchBar setBackgroundColor :[ UIColor clearColor ]];
}

// 获取当前正显示的视图控制器
+ (UIViewController *)getShowingViewingCtrl {
    UIViewController *returnCtrl = [self activityViewController];
    return  returnCtrl;
}

// 获取当前活跃控制器方法2
+ (UIViewController *)activityViewController {
    UIViewController* activityViewController = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if(tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0){
        UIView *frontView = [viewsArray objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            activityViewController = nextResponder;
        } else {
            activityViewController = window.rootViewController;
        }
    }
    return [self getRealCurrentViewCtrl:activityViewController];
}

+ (UIViewController *)getRealCurrentViewCtrl:(UIViewController *)ctrl {
    UIViewController *resultCtrl;
    if ([ctrl isKindOfClass:[UINavigationController class]]) {
        resultCtrl = [[(UINavigationController *)ctrl viewControllers] lastObject];
        return [self getRealCurrentViewCtrl:resultCtrl];
    }else if ([ctrl isKindOfClass:[UITabBarController class]]) {
        resultCtrl = [(UITabBarController *)ctrl selectedViewController];
        return [self getRealCurrentViewCtrl:resultCtrl];
    } else {
        resultCtrl = ctrl;
        return resultCtrl;
    }
}

#pragma mark - 处理按钮验证码倒计时

static NSString *remainTime;

//点击获取验证码后倒计时
+ (void)countDownAfterClick:(UIButton *)btn countDownSeconds:(int)seconds {
    btn.enabled = NO;
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    remainTime = [NSString stringWithFormat:@"%d",seconds];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getRemainingTime:) userInfo:@{@"btn":btn} repeats:YES];
}

+ (void)getRemainingTime:(NSTimer *)timer//定时计
{
    NSDictionary *userInfo = timer.userInfo;
    UIButton *btn = userInfo[@"btn"];
    if ([remainTime intValue] >= 1) {
        remainTime = [NSString stringWithFormat:@"%d",([remainTime intValue]- 1)];
        [btn setTitle:[NSString stringWithFormat:@"%@后可重获",remainTime] forState:UIControlStateNormal];
    }else {
        [timer invalidate];
        timer = nil;
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        btn.enabled = YES;
#ifdef NavBarColor
        [btn setBackgroundColor:NavBarColor];
#endif
    }
}


#pragma mark - 线程
+ (void)dispatchQueueWithBlock:(void(^)())dealBlock {
    [self dispatchQueueWithBlock:dealBlock aterBlockOnMainQueue:nil];
}

+ (void)dispatchMainQueueWithBlock:(void(^)())dealBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(dealBlock){
            dealBlock();
        }
    });
}

+ (void)dispatchQueueWithBlock:(void(^)())dealBlock aterBlockOnMainQueue:(void(^)())afterBlock {
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", NULL);
    dispatch_async(serialQueue, ^{
        if (dealBlock){
            dealBlock();
        }
        [self dispatchMainQueueWithBlock:afterBlock];
    });
    
    /*
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
     if (dealBlock){
     dealBlock();
     }
     [self dispatchMainQueueWithBlock:afterBlock];
     });
     */
}

#pragma mark - 字符串操作

// 对字符串进行“指定的字符后面的所有字符”的删除操作，获取指定字符串前一部分
+ (NSString *)getFrontStrOn:(NSString *)originStr byDeleteStr:(NSString *)deleteStr {
    NSString *newUserName = originStr;
    NSRange range = [originStr rangeOfString:deleteStr];
    if(range.location != NSNotFound)
    {
        newUserName = [originStr substringToIndex:range.location];
    }
    return newUserName;
}

// 对字符串进行“指定的字符前面的所有字符”的删除操作，获取指定字符串后一部分
+ (NSString *)getRearStrOn:(NSString *)originStr byDeleteStr:(NSString *)deleteStr {
    NSString *newUserName = originStr;
    NSRange range = [originStr rangeOfString:deleteStr];
    if(range.location != NSNotFound) {
        newUserName = [originStr substringFromIndex:(range.location + range.length)];
    }
    return newUserName;
}

// 对中文进行编码，返回编码后的字符串
+ (NSString *)encodeWithChineseStr:(NSString *)str {
    NSString *encodedStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedStr;
}

// 对已编码的中文字符串进行解码，返回正常中文字符串
+ (NSString *)decodeWithChineseStr:(NSString *)str {
    NSString *decodeStr = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return decodeStr;
}

// 去掉首位两端空格
+(NSString *)clearSpaceOnSides:(NSString *)str {
    NSString *resultStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return resultStr;
}

// 对服务器返回的时间类型字符串去掉T,替换成空格
+(NSString *)dealWithServerTimeStr:(NSString *)str {
    if (str.length){
        return [str stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }
    return nil;
}

// 对字符串中的特定字符串进行替换
+(NSString *)replaceStr:(NSString *)placedStr withStr:(NSString *)withStr onTotalStr:(NSString *)totalStr {
    if (totalStr.length){
        return [totalStr stringByReplacingOccurrencesOfString:placedStr withString:withStr];
    }
    return nil;
}

// 不区分大小写，判断两个字符串是否相同
+ (BOOL)isEqualCaseInsensitive:(NSString *)str1 withStr:(NSString *)str2 {
    // NSLiteralSearch 区分大小写(完全比较)
    // NSCaseInsensitiveSearch 不区分大小写
    // NSNumericSearch 只比较字符串的个数，而不比较字符串的字面值
    NSComparisonResult result = [str1 compare:str2 options:NSCaseInsensitiveSearch];
    return result == NSOrderedSame;
}

// 判断字符串是否是无效的字符串
+ (NSString *)isValidString:(NSString *)str {
    if (!str) return nil;
    if ([str isKindOfClass:[NSNull class]] || [str isEqual:[NSNull null]] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] || [str isEqualToString:@""] || [str isEqualToString:@"\0000"]) {
        return nil;
    }
    return str;
}

#pragma mark - 读取设备特定功能的访问权限
+ (BOOL)isCameraDenied {
    NSString * mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    // 被拒绝访问摄像头
    if (authorizationStatus == AVAuthorizationStatusRestricted || authorizationStatus == AVAuthorizationStatusDenied || TARGET_IPHONE_SIMULATOR) {
        [[[UIAlertView alloc] initWithTitle:@"无法访问相机" message:@"请在iPhone的“设置-隐私-相机”选项中，允许任易清单访问你的手机相机。" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil] show];
        return YES;
    }
    return NO;
}

+ (BOOL)isPhotoDenied
{
    ALAuthorizationStatus state = [ALAssetsLibrary authorizationStatus];
    if (state == ALAuthorizationStatusDenied || state == ALAuthorizationStatusRestricted) {
        [[[UIAlertView alloc] initWithTitle:@"无法访问照片" message:@"请在iPhone的“设置-隐私-照片”选项中，允许任易清单访问你的手机照片。" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil] show];
        return YES;
    }
    return NO;
}

+ (BOOL)isMicroPhoneDenied {
    __block BOOL isDenied = NO;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending) {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    isDenied = NO;
                }else {
                    isDenied = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:@"无法录音"
                                                    message:@"请在iPhone的“设置-隐私-麦克风”选项中，允许任易清单访问你的手机麦克风。"
                                                   delegate:nil
                                          cancelButtonTitle:@"好"
                                          otherButtonTitles:nil] show];
                    });
                }
            }];
        }
    }
    return isDenied;
}

+ (BOOL)isMobileContractsDenied {
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    if (authStatus == kABAuthorizationStatusDenied || authStatus == kABAuthorizationStatusRestricted) {
        [[[UIAlertView alloc] initWithTitle:@"无法访问通讯录" message:@"请在iPhone的“设置-隐私-通讯录”选项中，允许任易清单访问你的手机通讯录。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil] show];
        return YES;
    }
    
    return NO;
}

+ (BOOL)isLocationDenied {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied) {
        [[[UIAlertView alloc] initWithTitle:@"无法获取位置" message:@"请在iPhone的“设置-隐私-定位服务”选项中，允许任易清单定位获取附近的人。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil] show];
        return YES;
    }
    return NO;
}

#pragma mark - 多用户登录时，根据特定格式保存用户数据
+ (id)getUserDefaultWithKey:(NSString *)key onUser:(NSString *)userId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *realKey;
    if (userId) {
        realKey = [NSString stringWithFormat:@"%@_%@",userId,key];
    }else {
        //该种情况可能就是存储的数据不会因为切换用户的不同而有区别，比如：多用户共享的数据
        realKey = key;
    }
    return [defaults objectForKey:realKey];//注意，此处返回的都是id数据类型，所以在使用时如果是基本数据类型，需要通过具体的boolValue、intValue方法获取具体的数值
}

// 注意：此处我设置了存入的数据必须是对象类型，即使打算存入的是bool，int，也将其转换成NSNumber
+ (void)setUserDefaultWithKey:(NSString *)key onUser:(NSString *)userId value:(id)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *realKey;
    if (userId) {
        realKey = [NSString stringWithFormat:@"%@_%@",userId,key];
    }else {
        realKey = key;
    }
    [defaults setObject:value forKey:realKey];
    [defaults synchronize];
}

+ (void)clearUserDefaultWithKey:(NSString *)key onUser:(NSString *)userId  {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *realKey;
    if (userId) {
        realKey = [NSString stringWithFormat:@"%@_%@",userId,key];
    }else {
        realKey = key;
    }
    [defaults removeObjectForKey:realKey];
    [defaults synchronize];
}

#pragma mark - KeyChain保存UUID
// 设置uuid，并通过keyChain保存
+ (NSString *)setKeyChainValueWithBundleId:(NSString *)bundleId {
    NSString *strUUID = [SSKeychain passwordForService:bundleId account:@"UUID"];
    if (strUUID==nil||[strUUID isEqualToString:@""]) {
        [SSKeychain setPassword:[[NSUUID UUID] UUIDString] forService:bundleId  account:@"UUID"];
    }
    return strUUID;
}

// 从keyChain中取出uuid
+ (NSString *)getKeyChainValueWithBundleId:(NSString *)bundleId {
     NSString *strUUID = [SSKeychain passwordForService:bundleId account:@"UUID"];
    if (!strUUID) {
        strUUID = [self setKeyChainValueWithBundleId:bundleId];
    }
    return strUUID;
}

#pragma mark - 其他方法

// 对象是否有效
+ (id)isValidObj:(id)obj {
    if (!obj) return nil;
    if ([obj isKindOfClass:[NSNull class]] || [obj isEqual:[NSNull null]]) {
        return nil;
    }
    return obj;
}

+ (NSArray *)getScaleArray {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[ @1,@2,@3 ];
        } else if (screenScale <= 2) {
            scales = @[ @2,@3,@1 ];
        } else {
            scales = @[ @3,@2,@1 ];
        }
    });
    return scales;
}

+ (void)warnMainThreadIfNecessary {
    if (getenv("GHUNIT_CLI")) return;
    
    if ([NSThread isMainThread]) {
        NSLog(@"Warning: A long-running Paas operation is being executed on the main thread.");
    }
}

+(void)performSelectorIfCould:(id)target
                     selector:(SEL)selector
                       object:(id)arg1
                       object:(id)arg2
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([target respondsToSelector:selector])
    {
        [target performSelector:selector withObject:arg1 withObject:arg2];
    }
#pragma clang diagnostic pop
}

@end
