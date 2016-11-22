//
//  XYDTabBarControllerConfig.m
//  XYDTarbar
//
//  Created by xiong有都 on 16/6/27.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "TabBarControllerConfig.h"
#import "MainVCtrl.h"
#import "MoreVCtrl.h"
#import "RoundCircularButton.h"
#import "CustomNavigationCtrl.h"
#import "DCPathButton.h"

@interface TabBarControllerConfig ()<DCPathButtonDelegate>

@end

@implementation TabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return XYDTabBarController
 */
- (XYDTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        XYDTabBarController *tabBarController = [XYDTabBarController tabBarControllerWithViewControllers:self.viewControllers plusButton:nil isCenterSpace:YES tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    MainVCtrl *vctrl1 = [[MainVCtrl alloc] initWithNibName:@"MainVCtrl" bundle:nil];
    MoreVCtrl *vctrl2 = [[MoreVCtrl alloc] initWithNibName:@"MoreVCtrl" bundle:nil];
    
    CustomNavigationCtrl *nav1 = [CustomNavigationCtrl configNavigationCtrlwithRootVC:vctrl1     andImageName:nil OrColor:KNavBarColor];
    CustomNavigationCtrl *nav2 = [CustomNavigationCtrl configNavigationCtrlwithRootVC:vctrl2 andImageName:nil OrColor:KNavBarColor];
    
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `XYDTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    //tabBarController.imageInsets = UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    //tabBarController.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
    NSArray *viewControllers = @[nav1,nav2];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  XYDTabBarItemTitle : @"主页",
                                                  XYDTabBarItemImage : @"tab_onlinedisk",
                                                  XYDTabBarItemSelectedImage : @"tab_onlinedisk_h",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 XYDTabBarItemTitle : @"好友",
                                                 XYDTabBarItemImage : @"tab_transferlog",
                                                 XYDTabBarItemSelectedImage : @"tab_transferlog_h",
                                                 };
    NSArray *tabBarItemsAttributes = @[
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(XYDTabBarController *)tabBarController {
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
}


- (void)configureDCPathButton {
    // Configure center button
    DCPathButton *dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
                                                         highlightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    dcPathButton.delegate = self;
    
    // Configure item buttons
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-place"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-camera"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_4 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-thought"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_5 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-sleep"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-sleep-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    // Add the item button into the center button
    [dcPathButton addPathItems:@[itemButton_1,
                                 itemButton_2,
                                 itemButton_3,
                                 itemButton_4,
                                 itemButton_5
                                 ]];
    
    // Change the bloom radius, default is 105.0f
    dcPathButton.bloomRadius = 120.0f;
    
    // Change the DCButton's center
    dcPathButton.dcButtonCenter = CGPointMake(self.tabBarController.view.bounds.size.width / 2, self.tabBarController.view.bounds.size.height - 25.5f);
    
    // Setting the DCButton appearance
    dcPathButton.allowSounds = YES;
    dcPathButton.allowCenterButtonRotation = YES;
    
    dcPathButton.bottomViewColor = [UIColor blackColor];
    dcPathButton.bloomDirection = kDCPathButtonBloomDirectionTop;
    [self.tabBarController.view addSubview:dcPathButton];
}

#pragma mark - DCPathButton Delegate

- (void)willPresentDCPathButtonItems:(DCPathButton *)dcPathButton {
    
    NSLog(@"ItemButton will present");
    
}

- (void)pathButton:(DCPathButton *)dcPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex {
    NSLog(@"You tap %@ at index : %tu", dcPathButton, itemButtonIndex);
}

- (void)didPresentDCPathButtonItems:(DCPathButton *)dcPathButton {
    
    NSLog(@"ItemButton did present");
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
