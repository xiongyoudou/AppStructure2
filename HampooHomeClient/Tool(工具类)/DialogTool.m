//
//  HudAndAlertViewUtils.m
//  自我提高大杂烩
//
//  Created by iMac on 14-11-10.
//  Copyright (c) 2014年 iMac. All rights reserved.
//

#import "DialogTool.h"

typedef enum {
    ShowHudType,//仅仅显示内容
    ModifyHudType,//修改Hud，显示最新内容
}HudType;

@implementation DialogTool {
    MBProgressHUD *progressHud;
    UIAlertView *alert;
}

+ (DialogTool *)sharedInstance {
    static DialogTool *sharedInstance = nil ;
    static dispatch_once_t onceToken;  // 锁
    dispatch_once (&onceToken, ^ {     // 最多调用一次
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// 当第一次使用这个单例时，会调用这个init方法。
- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)showCommonHud:(UIView *)superView text:(NSString *)text workBlock:(void (^)())workBlock doneBlock:(void (^)())doneBlock{
    [self showHud:superView type:ShowHudType mode:MBProgressHUDModeIndeterminate text:text work:workBlock doneBlock:doneBlock hideAfterDelay:0];
}


-(void)showCommonHud:(UIView *)superView text:(NSString *)text{
    [self showHud:superView type:ShowHudType mode:MBProgressHUDModeIndeterminate text:text work:nil doneBlock:nil hideAfterDelay:0];
}

-(void)showCommonHud:(UIView *)superView text:(NSString *)text dismissAfterDelay:(CGFloat)dealy {
    [self showHud:superView type:ShowHudType mode:MBProgressHUDModeIndeterminate text:text work:nil doneBlock:nil hideAfterDelay:dealy];
}


-(void)showTextHud:(UIView *)superView workBlock:(void (^)())workBlock doneBlock:(void (^)())doneBlock text:(NSString *)text{
    [self showHud:superView type:ShowHudType mode:MBProgressHUDModeText text:text work:workBlock doneBlock:doneBlock hideAfterDelay:0];
}


-(void)showTextHud:(UIView *)superView text:(NSString *)text{
    [self showHud:superView type:ShowHudType mode:MBProgressHUDModeText text:text work:nil doneBlock:nil hideAfterDelay:0];
}


-(void)showTextHud:(UIView *)superView hideAfterDelay:(CGFloat)delay text:(NSString *)text{
    [self showHud:superView type:ShowHudType mode:MBProgressHUDModeText text:text work:nil doneBlock:nil hideAfterDelay:delay];
}

/**
 *  之所以需要此方法，原因是因为有时候Hud还没消失，就由其他Hud要显示，所以我根据hud是否为nil来判断是否显示新的nil，比如modifyTextOnTextHud方法和showCommonHudWith方法
 *
 */
-(void)hideAfterDelay{
    progressHud = nil;
}

// 此方法修改当前正显示的文字框的内容。比如在发送反馈内容时，先显示“正在发送...”,发送成功后，立马将内容改为“发送成功”，并在指定时间后消失
-(void)modifyTextOnTextHud:(NSString *)text dismissAfterDelay:(CGFloat)delay{
    [self showHud:nil type:ModifyHudType mode:MBProgressHUDModeText text:text work:nil doneBlock:nil hideAfterDelay:delay];
}

// 此方法修改当前正显示的文字框的内容。比如在发送反馈内容时，先显示“正在发送...”,发送成功后，立马将内容改为“发送成功”，并在指定时间后消失
-(void)modifyTextOnTextHud:(NSString *)text andSuperView:(UIView *)superView dismissAfterDelay:(CGFloat)delay{
    [self showHud:superView type:ModifyHudType mode:MBProgressHUDModeText text:text work:nil doneBlock:nil hideAfterDelay:delay];
}

-(void)modifyTextOnTextHud:(NSString *)text andSuperView:(UIView *)superView dismissAfterDelay:(CGFloat)delay andWorkDone:(void (^)())workDoneBlock {
    [self showHud:superView type:ModifyHudType mode:MBProgressHUDModeText text:text work:nil doneBlock:workDoneBlock hideAfterDelay:delay];
}

- (void)modifyTextOnTextHud:(NSString *)text dismissAfterDelay:(CGFloat)delay andWorkDone:(void (^)())workDoneBlock
{
    [self modifyTextOnTextHud:text dismissAfterDelay:delay];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), workDoneBlock);
}

//此处应用情形是：显示一朵菊花一直在转（此处有请求在发送，并等候反馈），等收到反馈成，调用此方法，显示打钩（成功）
-(void)showFinishHudWithText:(NSString *)text dismissAfterDelay:(CGFloat)delay{
    if(progressHud){
        progressHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        progressHud.mode = MBProgressHUDModeCustomView;
        progressHud.label.text = text;
        [progressHud showAnimated:YES];
        [progressHud hideAnimated:YES afterDelay:delay];
        [self performSelector:@selector(hideAfterDelay) withObject:nil afterDelay:delay];
    }
}

-(void)showSimpleAlertView:(NSString *)text {
    [self removeProgressHud];
    if (text.length && !alert) {
        //防止连续的弹出多个alertView
        alert = [[UIAlertView alloc]initWithTitle:nil message:text delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        alert.delegate = self;
        [alert show];
    }
}

/**
 *  根据参数处理提示框
 *
 *  @param superView 提示框加载的父视图
 *  @param type      提示框操作类型，是只显示，还是修改
 *  @param mode      提示框显示样式
 *  @param text      提示内容
 *  @param workBlock 提示框显示时执行的事务
 *  @param doneBlock 事务执行完之后的操作
 *  @param delay     指定时间之后隐藏
 */
- (void)showHud:(UIView *)superView type:(HudType)type mode:(MBProgressHUDMode)mode  text:(NSString *)text work:(void (^)())workBlock doneBlock:(void (^)())doneBlock hideAfterDelay:(CGFloat)delay {
    switch (type) {
        case ShowHudType:{
            [self removeProgressHud];
            if (!progressHud) {
                progressHud = [[MBProgressHUD alloc] initWithFrame:superView.bounds];
                progressHud.mode = mode;
                progressHud.label.text = text;
                progressHud.margin = 10.f;
                //    globalHud.yOffset = 150.f;//再向下偏移150个点
                [superView addSubview:progressHud];
                [progressHud showAnimated:YES];
            }
        }
            break;
        case ModifyHudType:{
            if (progressHud){
                progressHud.label.text = text;
                [progressHud showAnimated:YES];
            }else {
                [self showHud:superView type:ShowHudType mode:mode text:text work:workBlock doneBlock:doneBlock hideAfterDelay:delay];
                return;
            }
        }
            break;
        default:
            break;
    }
    
    if (delay != 0){
        [progressHud hideAnimated:YES afterDelay:delay];
        [self performSelector:@selector(hideAfterDelay) withObject:nil afterDelay:delay];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
        if (workBlock){
            workBlock();
        }
        dispatch_async(dispatch_get_main_queue(),^{
            if (doneBlock){
                doneBlock();
            }
        });
    });
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [alert removeFromSuperview];
    alert = nil;
}

-(void)removeProgressHud {
    if(progressHud) {
        [progressHud removeFromSuperview];
        progressHud = nil;
    }
}

-(BOOL)isHudShowing {
    if (progressHud) {
        return YES;
    }else{
        return NO;
    }
}


@end
