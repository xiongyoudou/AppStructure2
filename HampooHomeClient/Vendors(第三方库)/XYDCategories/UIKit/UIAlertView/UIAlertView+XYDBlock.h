//
//  UIAlertView+Block.h

//
//  Created by 符现超 on 15/5/9.
//  Copyright (c) 2015年 http://weibo.com/u/1655766025 All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewJKCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (XYDBlock)<UIAlertViewDelegate>

@property (nonatomic, copy) UIAlertViewJKCallBackBlock xyd_alertViewCallBackBlock;

+ (void)xyd_alertWithCallBackBlock:(UIAlertViewJKCallBackBlock)alertViewCallBackBlock
                            title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName
                otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
