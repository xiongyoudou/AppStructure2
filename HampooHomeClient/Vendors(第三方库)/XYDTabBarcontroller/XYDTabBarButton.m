//
//  XYDTabBarButton.m
//  XYDTarbar
//
//  Created by xiong有都 on 16/6/30.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "XYDTabBarButton.h"
#import "XYDBadgeButton.h"

// 图标的比例
#define XYDTabbarItemImageRatio 0.7

// 按钮的默认文字颜色
#define  XYDTabbarItemTitleColor COLOR(116,116,116,1.0)
// 按钮的选中文字颜色
#define  XYDTabbarItemTitleSelectedColor COLOR(0,128,255,1.0)

@interface XYDTabBarButton () {

}

/**
 *  提醒数字
 */
@property (nonatomic, weak) XYDBadgeButton *badgeButton;


@end

@implementation XYDTabBarButton

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        // 文字颜色
        [self setTitleColor:XYDTabbarItemTitleColor forState:UIControlStateNormal];
        [self setTitleColor:XYDTabbarItemTitleSelectedColor forState:UIControlStateSelected];
        
        // 添加一个提醒数字按钮
        XYDBadgeButton *badgeButton = [[XYDBadgeButton alloc] init];
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

#pragma mark - 重写去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted {}

#pragma mark - 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * XYDTabbarItemImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

#pragma mark - 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * XYDTabbarItemImageRatio -5;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

#pragma mark - 设置数据
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // KVO 监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

/**
 *  监听到某个对象的属性改变了,就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

#pragma mark - 调整badgeButton的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat centerX = self.frame.size.width * 0.72;
    CGFloat centerY = self.frame.size.height * 0.19;
    self.badgeButton.center = CGPointMake(centerX, centerY);
}


@end
