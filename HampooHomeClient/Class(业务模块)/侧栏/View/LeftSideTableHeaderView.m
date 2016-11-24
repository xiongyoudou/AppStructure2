//
//  LeftSideTableHeaderView.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/21.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "LeftSideTableHeaderView.h"

@implementation LeftSideTableHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageV.layer.cornerRadius = self.headImageV.bounds.size.width / 2;
    self.headImageV.layer.masksToBounds = YES;
}

@end
