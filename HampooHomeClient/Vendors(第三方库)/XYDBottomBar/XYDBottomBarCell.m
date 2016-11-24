//
//  XYDBottomBarCell.m
//  MiniPC
//
//  Created by xiongyoudou on 16/5/16.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "XYDBottomBarCell.h"

@interface XYDBottomBarCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@end

@implementation XYDBottomBarCell

-(void)configWithBarData:(XYDBottomBarData *)data {
    self.textLabel.text = data.title;
    self.imageV.image = [UIImage imageNamed:data.imageName];
}

@end
