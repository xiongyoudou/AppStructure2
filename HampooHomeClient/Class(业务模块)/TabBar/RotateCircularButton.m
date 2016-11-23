//
//  RotateCircularButton.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/23.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "RotateCircularButton.h"

@implementation RotateCircularButton
@synthesize btnSelected = _btnSelected;

#pragma mark -
#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    // 设置被选中状态
    self.selected = NO;
    // 背景图片
    [self setBackgroundImage:[UIImage imageNamed:@"chooser-button-input"] forState:UIControlStateNormal];
    // 添加点击
    [self addTarget:self action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    self.clipsToBounds = YES;
    self.frame = CGRectMake(0, 0, 40, 40);
}


#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

- (void)plusChildViewControllerButtonClicked:(UIButton<XYDPlusButtonProtocol> *)sender {
    sender.btnSelected = YES;
}

- (CGFloat)plusButtonWidth {
//    return self.frame.size.width;
    return 80;
}

- (void)setBtnSelected:(BOOL)btnSelected {
    _btnSelected = btnSelected;
    self.selected = _btnSelected;
}

- (BOOL)btnSelected {
    return _btnSelected;
}

#pragma mark - CYLPlusButtonSubclassing

- (UIViewController *)plusChildViewController {
    return nil;
}

- (NSUInteger)indexOfPlusButtonInTabBar {
    return 1;
}

- (CGFloat)multiplerInCenterY {
    return  0.5;
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {

    if (!self.isSelected) {
        [UIView animateWithDuration:0.25 animations:^{
            self.transform = CGAffineTransformMakeRotation(M_PI_4);
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    }
    self.btnSelected = !self.btnSelected;
    NSLog(@"点击按钮");
}


@end
