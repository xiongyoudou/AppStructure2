//
//  MainVCtrl.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/8.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "MainVCtrl.h"
#import "LeftSlideVCtrlProtocol.h"
#import "LeftSlideViewController.h"
#import "WYPopoverController.h"
#import "SelectOptionVCtrl.h"

@interface MainVCtrl ()<WYPopoverControllerDelegate> {
    WYPopoverController *selectOptionVCtrl;
}

@end

@implementation MainVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

#pragma mark - UI
- (void)configUI {
    [AppTool setLeftNaviMenuItem:self];
    
    UIButton *rightBtn = [AppTool getNavigationBtnImage:[UIImage imageNamed:@"nav_menu"] target:self action:@selector(clickRightBtn:) frame:CGRectMake(0, 0, 40, 44)];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

#pragma mark - actions

- (void)clickRightBtn:(UIButton *)btn {
    SelectOptionVCtrl *optionCtrl = [[SelectOptionVCtrl  alloc] initWithNibName:@"SelectOptionVCtrl" bundle:nil];
    optionCtrl.dataArray = @[@{@"text":@"发起群聊",@"imageName":@"contacts_add_newmessage"},@{@"text":@"添加朋友",@"imageName":@"contacts_add_friend"},@{@"text":@"扫一扫",@"imageName":@"contacts_add_scan"},@{@"text":@"拍照分享",@"imageName":@"contacts_add_photo"}];
    CGSize cellSize = CGSizeMake(150, 40);
    optionCtrl.preferredContentSize = CGSizeMake(cellSize.width, 15 + cellSize.height * optionCtrl.dataArray.count);
    optionCtrl.modalInPopover = NO;
    selectOptionVCtrl = [[WYPopoverController alloc] initWithContentViewController:optionCtrl];
    selectOptionVCtrl.theme.fillTopColor = COLOR(47,53,53,1);
    selectOptionVCtrl.delegate = self;
    selectOptionVCtrl.passthroughViews = @[btn];
    selectOptionVCtrl.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
    selectOptionVCtrl.wantsDefaultContentAppearance = NO;

    [selectOptionVCtrl presentPopoverFromRect:btn.bounds
                                       inView:btn
                     permittedArrowDirections:WYPopoverArrowDirectionAny
                                     animated:YES
                                      options:WYPopoverAnimationOptionFadeWithScale];
    
}

#pragma mark - WYPopoverControllerDelegate

- (void)popoverControllerDidPresentPopover:(WYPopoverController *)controller {
    NSLog(@"popoverControllerDidPresentPopover");
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller {
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller{

    selectOptionVCtrl.delegate = nil;
    selectOptionVCtrl = nil;
}

- (BOOL)popoverControllerShouldIgnoreKeyboardBounds:(WYPopoverController *)popoverController {
    return YES;
}

- (void)popoverController:(WYPopoverController *)popoverController willTranslatePopoverWithYOffset:(float *)value {
    // keyboard is shown and the popover will be moved up by 163 pixels for example ( *value = 163 )
    *value = 0; // set value to 0 if you want to avoid the popover to be moved
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
