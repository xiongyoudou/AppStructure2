//
//  EmptyCenterView.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/23.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "EmptyCenterView.h"

@implementation EmptyCenterView

@synthesize btnSelected = _btnSelected;

#pragma mark -
#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

- (void)plusChildViewControllerButtonClicked:(UIButton<XYDPlusButtonProtocol> *)sender {
    sender.btnSelected = YES;
}

- (CGFloat)plusButtonWidth {
    return 80;
}

- (void)setBtnSelected:(BOOL)btnSelected {
    _btnSelected = btnSelected;
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
    return  0.3;
}


@end
