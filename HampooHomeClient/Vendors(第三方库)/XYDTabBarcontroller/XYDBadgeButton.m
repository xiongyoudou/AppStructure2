//
//  XYDBadgeButton.m
//  XYDTarbar
//
//  Created by xiong有都 on 16/6/30.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "XYDBadgeButton.h"

@implementation XYDBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        UIImage *backImage = [UIImage imageNamed:@"main_badge"];
        [self setBackgroundImage:[backImage stretchableImageWithLeftCapWidth:backImage.size.width * 0.5 topCapHeight:backImage.size.height * 0.5] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (!badgeValue) { // nil
        // 隐藏按钮
        self.hidden = YES;
    } else if (badgeValue.length == 0) { // 只显示红点
        // 显示按钮
        self.hidden = NO;
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = 10;
        CGFloat badgeW = 10;
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else { // 显示带数目的红点
        // 显示按钮
        self.hidden = NO;
        
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    }
}


@end
