//
//  XYDBottomBarCell.h
//  MiniPC
//
//  Created by xiongyoudou on 16/5/16.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYDBottomBarData.h"

@interface XYDBottomBarCell : UIView

@property (weak, nonatomic) IBOutlet UIButton *backgroundBtn;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
-(void)configWithBarData:(XYDBottomBarData *)data;

@end
