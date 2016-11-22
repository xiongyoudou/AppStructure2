//
//  XYDTabBarController.m
//  XYDTarbar
//
//  Created by xiong有都 on 16/6/19.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <objc/runtime.h>
#import "XYDTabBarController.h"
#import "XYDTabBar.h"

NSString *const XYDTabBarItemTitle = @"XYDTabBarItemTitle";
NSString *const XYDTabBarItemImage = @"XYDTabBarItemImage";
NSString *const XYDTabBarItemSelectedImage = @"XYDTabBarItemSelectedImage";


@interface NSObject (XYDTabBarController)

- (void)xyd_setTabBarController:(XYDTabBarController *)tabBarController;

@end

@interface XYDTabBarController () <UITabBarControllerDelegate>

@end

@implementation XYDTabBarController

@synthesize viewControllers = _viewControllers;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (instancetype)initWithPlusButton:(XYDPlusButton <XYDPlusButtonProtocol> *)button {
    if (self = [super init]) {
        _plusButton = button;
        // 处理tabBar，使用自定义 tabBar 添加 发布按钮
        [self setUpTabBar];
        self.delegate = self;
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    if (!self.tabBarHeight) {
        return;
    }
    self.tabBar.frame = ({
        CGRect frame = self.tabBar.frame;
        CGFloat tabBarHeight = self.tabBarHeight;
        frame.size.height = tabBarHeight;
        frame.origin.y = self.view.frame.size.height - tabBarHeight;
        frame;
    });
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [(XYDTabBar *)self.tabBar removeAllOriginalTabBarSubV];
}

- (void)dealloc {
}

#pragma mark -
#pragma mark - public Methods

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers plusButton:(XYDPlusButton<XYDPlusButtonProtocol> *)plusButton isCenterSpace:(BOOL)isCenterSpace tabBarItemsAttributes:(NSArray<NSDictionary *> *)tabBarItemsAttributes {
    _isCenterSpace = isCenterSpace;
    if (self = [self initWithPlusButton:plusButton]) {
        _tabBarItemsAttributes = tabBarItemsAttributes;
        self.viewControllers = viewControllers;
    }
    return self;
}

+ (instancetype)tabBarControllerWithViewControllers:(NSArray<UIViewController *> *)viewControllers plusButton:(XYDPlusButton<XYDPlusButtonProtocol> *)plusButton isCenterSpace:(BOOL)isCenterSpace tabBarItemsAttributes:(NSArray<NSDictionary *> *)tabBarItemsAttributes {
    XYDTabBarController *tabBarController = [[XYDTabBarController alloc] initWithViewControllers:viewControllers plusButton:plusButton isCenterSpace:isCenterSpace tabBarItemsAttributes:tabBarItemsAttributes];
    return tabBarController;
}

#pragma mark -
#pragma mark - Private Methods

/**
 *  利用 KVC 把系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar {
    XYDTabBar *tabBar = [[XYDTabBar alloc] init];
    tabBar.clickTabbarItemBlock = ^(NSInteger fromItemIndex,NSInteger toItemIndex) {
        self.selectedIndex = toItemIndex;
    };
    tabBar.plusButton = self.plusButton;
    tabBar.isCenterSpace = self.isCenterSpace;
    tabBar.tabBarController = self;
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    if (_viewControllers && _viewControllers.count) {
        for (UIViewController *viewController in _viewControllers) {
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
    }
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        if ((!_tabBarItemsAttributes) || (_tabBarItemsAttributes.count != viewControllers.count)) {
            [NSException raise:@"XYDTabBarController" format:@"The count of XYDTabBarControllers is not equal to the count of tabBarItemsAttributes.【Chinese】设置_tabBarItemsAttributes属性时，请确保元素个数与控制器的个数相同，并在方法`-setViewControllers:`之前设置"];
        }
        
        if (_plusButton) {
            NSMutableArray *viewControllersWithPlusButton = [NSMutableArray arrayWithArray:viewControllers];
            if ([_plusButton plusChildViewController]) {
                [viewControllersWithPlusButton insertObject:[_plusButton plusChildViewController] atIndex:[_plusButton indexOfPlusButtonInTabBar]];
            }
            _viewControllers = [viewControllersWithPlusButton copy];
        } else {
            _viewControllers = [viewControllers copy];
        }
        
        NSUInteger idx = 0;
        for (UIViewController *viewController in _viewControllers) {
            NSString *title = nil;
            NSString *normalImageName = nil;
            NSString *selectedImageName = nil;
            if (viewController != [_plusButton plusChildViewController]) {
                title = _tabBarItemsAttributes[idx][XYDTabBarItemTitle];
                normalImageName = _tabBarItemsAttributes[idx][XYDTabBarItemImage];
                selectedImageName = _tabBarItemsAttributes[idx][XYDTabBarItemSelectedImage];
            } else {
                idx--;
            }
            
            [self addOneChildViewController:viewController
                                  WithTitle:title
                            normalImageName:normalImageName
                          selectedImageName:selectedImageName];
            [viewController xyd_setTabBarController:self];
            idx++;
        }
    } else {
        for (UIViewController *viewController in _viewControllers) {
            [viewController xyd_setTabBarController:nil];
        }
        _viewControllers = nil;
    }
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param normalImageName   图片
 *  @param selectedImageName 选中图片
 */
- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName {
    UITabBarItem *barItem = [[UITabBarItem alloc]init];
    barItem.title = title;
    if (normalImageName) {
        UIImage *normalImage = [UIImage imageNamed:normalImageName];
        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        barItem.image = normalImage;
    }
    if (selectedImageName) {
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        barItem.selectedImage = selectedImage;
    }
    if (self.shouldCustomizeImageInsets) {
        barItem.imageInsets = self.imageInsets;
    }
    if (self.shouldCustomizeTitlePositionAdjustment) {
        barItem.titlePositionAdjustment = self.titlePositionAdjustment;
    }
    [self addChildViewController:viewController];
    viewController.tabBarItem = barItem;
    [(XYDTabBar *)self.tabBar addTabBarButtonWithItem:barItem];
}

- (BOOL)shouldCustomizeImageInsets {
    BOOL shouldCustomizeImageInsets = self.imageInsets.top != 0.f || self.imageInsets.left != 0.f || self.imageInsets.bottom != 0.f || self.imageInsets.right != 0.f;
    return shouldCustomizeImageInsets;
}

- (BOOL)shouldCustomizeTitlePositionAdjustment {
    BOOL shouldCustomizeTitlePositionAdjustment = self.titlePositionAdjustment.horizontal != 0.f || self.titlePositionAdjustment.vertical != 0.f;
    return shouldCustomizeTitlePositionAdjustment;
}

- (void)offsetTabBarSwappableImageViewToFit:(CGFloat)swappableImageViewDefaultOffset {
    if (self.shouldCustomizeImageInsets) {
        return;
    }
    NSArray<UITabBarItem *> *tabBarItems = [self xyd_tabBarController].tabBar.items;
    [tabBarItems enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIEdgeInsets imageInset = UIEdgeInsetsMake(swappableImageViewDefaultOffset, 0, -swappableImageViewDefaultOffset, 0);
        obj.imageInsets = imageInset;
        if (!self.shouldCustomizeTitlePositionAdjustment) {
            obj.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
        }
    }];
}

#pragma mark - delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController*)viewController {
    NSUInteger selectedIndex = tabBarController.selectedIndex;
    if (_plusButton) {
        if ((selectedIndex == [_plusButton indexOfPlusButtonInTabBar]) && (viewController != [_plusButton plusChildViewController])) {
            _plusButton.selected = NO;
        }
    }
    return YES;
}

@end


@implementation UIViewController (XYDTabBarController)

- (void)xyd_setTabBarController:(XYDTabBarController *)tabBarController {
    objc_setAssociatedObject(self, @selector(xyd_tabBarController), tabBarController, OBJC_ASSOCIATION_ASSIGN);
}

- (XYDTabBarController *)xyd_tabBarController {
    XYDTabBarController *tabBarController = objc_getAssociatedObject(self, @selector(xyd_tabBarController));
    if (tabBarController) {
        return tabBarController;
    }
    if ([self isKindOfClass:[UIViewController class]] && [(UIViewController *)self parentViewController]) {
        tabBarController = [[(UIViewController *)self parentViewController] xyd_tabBarController];
        return tabBarController;
    }
    id<UIApplicationDelegate> delegate = ((id<UIApplicationDelegate>)[[UIApplication sharedApplication] delegate]);
    UIWindow *window = delegate.window;
    if ([window.rootViewController isKindOfClass:[XYDTabBarController class]]) {
        tabBarController = (XYDTabBarController *)window.rootViewController;
    }
    return tabBarController;
}

@end
