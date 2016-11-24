//
//  HudAndAlertViewUtils.h
//  自我提高大杂烩
//
//  Created by iMac on 14-11-10.
//  Copyright (c) 2014年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface DialogTool : NSObject

+ (DialogTool *)sharedInstance;

-(void)showCommonHud:(UIView *)superView text:(NSString *)text workBlock:(void (^)())workBlock doneBlock:(void (^)())doneBlock;
-(void)showCommonHud:(UIView *)superView text:(NSString *)text;
-(void)showCommonHud:(UIView *)superView text:(NSString *)text dismissAfterDelay:(CGFloat)dealy;

-(void)showTextHud:(UIView *)superView workBlock:(void (^)())workBlock doneBlock:(void (^)())doneBlock text:(NSString *)text;
-(void)showTextHud:(UIView *)superView text:(NSString *)text;
-(void)showTextHud:(UIView *)superView hideAfterDelay:(CGFloat)delay text:(NSString *)text;
-(void)modifyTextOnTextHud:(NSString *)text dismissAfterDelay:(CGFloat)delay;
-(void)modifyTextOnTextHud:(NSString *)text andSuperView:(UIView *)superView dismissAfterDelay:(CGFloat)delay;
-(void)modifyTextOnTextHud:(NSString *)text andSuperView:(UIView *)superView dismissAfterDelay:(CGFloat)delay andWorkDone:(void (^)())workDoneBlock;
- (void)modifyTextOnTextHud:(NSString *)text dismissAfterDelay:(CGFloat)delay andWorkDone:(void (^)())workDoneBlock;
-(void)showFinishHudWithText:(NSString *)text dismissAfterDelay:(CGFloat)delay;

-(void)showSimpleAlertView:(NSString *)text;

-(void)removeProgressHud;

-(BOOL)isHudShowing;


@end
