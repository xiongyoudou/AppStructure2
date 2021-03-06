//
//  XYDTabBar.h
//  XYDTarbar
//
//  Created by xiong有都 on 16/6/19.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYDPlusButtonProtocol.h"
@class XYDTabBarController;

@interface XYDTabBar : UITabBar

typedef void(^ClickTabbarItemBlock)(NSInteger fromItemIndex,NSInteger toItemIndex);

/*!
 * 让 `SwappableImageView` 垂直居中时，所需要的默认偏移量。
 * @attention 该值将在设置 top 和 bottom 时被同时使用，具体的操作等价于如下行为：
 * `viewController.tabBarItem.imageInsets = UIEdgeInsetsMake(swappableImageViewDefaultOffset, 0, -swappableImageViewDefaultOffset, 0);`
 */
@property (nonatomic, assign, readonly) CGFloat swappableImageViewDefaultOffset;


@property (nonatomic,weak,nullable) XYDTabBarController *tabBarController;
// custom plusButton instance
@property (nonatomic,strong,nullable) UIView <XYDPlusButtonProtocol> *plusButton;
@property (nonatomic,copy,nullable) ClickTabbarItemBlock clickTabbarItemBlock;

/**
 *  当前被选择的item的下标
 */
@property (nonatomic, assign) NSUInteger selectedItemIndex;

- (void)addTabBarButtonWithItem:(nullable UITabBarItem *)item;
- (void)removeAllOriginalTabBarSubV;

@end
