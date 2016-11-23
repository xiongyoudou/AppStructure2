//
//  XYDRoundCircularButton.m
//  XYDTarbar
//
//  Created by xiong有都 on 16/6/29.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "RoundCircularButton.h"

@implementation RoundCircularButton
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
    UIImage *buttonImage = [UIImage imageNamed:@"post_normal"];
    [self setImage:buttonImage forState:UIControlStateNormal];
    [self setTitle:@"创建" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [self setTitle:@"创建" forState:UIControlStateSelected];
    [self setTitleColor:KNavBarColor forState:UIControlStateSelected];
    
    self.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [self sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    [self addTarget:self action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.adjustsImageWhenHighlighted = NO;
}


//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.7;
    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 0.9;
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdgeWidth;
    CGFloat const verticalMargin  = verticalMarginT / 2;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeWidth * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeWidth  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

- (void)plusChildViewControllerButtonClicked:(UIButton<XYDPlusButtonProtocol> *)sender {
    sender.btnSelected = YES;
}

- (CGFloat)plusButtonWidth {
    return self.frame.size.width;
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
    return  0.3;
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    self.btnSelected = !self.btnSelected;
    NSLog(@"点击按钮");
}


@end
