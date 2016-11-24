//
//  XYDTabBar.m
//  XYDTarbar
//
//  Created by xiong有都 on 16/6/19.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "XYDTabBar.h"
#import "XYDTabBarController.h"
#import "XYDTabBarButton.h"


static void *const XYDTabBarContext = (void*)&XYDTabBarContext;

@interface XYDTabBar () {
    XYDTabBarButton *_selectedBarButton;
}

@property (nonatomic, assign) CGFloat tabBarItemWidth;
@property (nonatomic, strong) NSMutableArray *barItems;


@end

@implementation XYDTabBar

#pragma mark -
#pragma mark - LifeCycle Method

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (NSMutableArray *)barItems {
    if (_barItems == nil) {
        _barItems = [NSMutableArray array];
    }
    return _barItems;
}

// 移除原生的uitabBarButton，添加自定义的item
- (void)removeAllOriginalTabBarSubV {
    for (UIView *child in self.subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [child removeFromSuperview];
        }
    }
}

#pragma mark - 添加一个item
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    XYDTabBarButton *tabBarButton = [[XYDTabBarButton alloc]init];
    NSDictionary *normalAttribute = [[UITabBarItem appearance]titleTextAttributesForState:UIControlStateNormal];
    NSDictionary *selectedAttribute = [[UITabBarItem appearance]titleTextAttributesForState:UIControlStateSelected];
    [tabBarButton setTitleColor:normalAttribute[NSForegroundColorAttributeName] forState:UIControlStateNormal];
    [tabBarButton setTitleColor:selectedAttribute[NSForegroundColorAttributeName] forState:UIControlStateSelected];
    [self addSubview:tabBarButton];

    // 2.设置数据
    tabBarButton.item = item;
    tabBarButton.tag = self.barItems.count;
    
    // 3.监听按钮点击
    [tabBarButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.添加按钮到数组中
    [self.barItems addObject:tabBarButton];
    
    // 5.默认选中第0个按钮
    if (self.barItems.count == 1) {
        [self buttonClick:tabBarButton];
    }
}

#pragma mark - 监听按钮点击
- (void)buttonClick:(XYDTabBarButton *)barItem {
    // 1.处理点击事件
    if (_clickTabbarItemBlock) {
        _clickTabbarItemBlock(_selectedBarButton.tag,barItem.tag);
    }
    
    // 2.设置按钮的状态
    _selectedBarButton.selected = NO;
    barItem.selected = YES;
    _selectedBarButton = barItem;
    
    // 3.设置当前被选中的index
    _selectedItemIndex = barItem.tag;
}

#pragma mark - 设置当前被选择item
- (void)setSelectedItemIndex:(NSUInteger)selectedItemIndex
{
    if (selectedItemIndex > self.items.count) {
        return;
    }
    // 获取当前被选择的XYDTabbarItem
    XYDTabBarButton *barItem = [self.barItems objectAtIndex:selectedItemIndex];
    [self buttonClick:barItem];
}


- (void)setPlusButton:(UIView<XYDPlusButtonProtocol> *)plusButton {
    _plusButton = plusButton;
    [self sharedInit];
}

- (instancetype)sharedInit {
    if (_plusButton) {
        [self addSubview:_plusButton];
    }
    // KVO注册监听
    _tabBarItemWidth = 0;
    [self addObserver:self forKeyPath:@"tabBarItemWidth" options:NSKeyValueObservingOptionNew context:XYDTabBarContext];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    
    _tabBarItemWidth = (barWidth - [_plusButton plusButtonWidth]) / [_tabBarController.viewControllers count];

    CGFloat multiplerInCenterY = [self multiplerInCenterY];
    self.plusButton.center = CGPointMake(barWidth * 0.5, barHeight * multiplerInCenterY);
    if (self.barItems.count) {
        [self setupSwappableImageViewDefaultOffset:self.barItems[0]];
        NSUInteger plusButtonIndex = [self plusButtonIndex];
        [self.barItems enumerateObjectsUsingBlock:^(UIView * _Nonnull childView, NSUInteger buttonIndex, BOOL * _Nonnull stop) {
            //调整UITabBarItem的位置
            CGFloat buttonX = buttonIndex * _tabBarItemWidth;
            if (buttonIndex >= plusButtonIndex) {
                if (_plusButton) {
                    buttonX += [_plusButton plusButtonWidth];
                }
            }
            //仅修改childView的x和宽度,yh值不变
            childView.frame = CGRectMake(buttonX, 0, _tabBarItemWidth, barHeight);
        }];
    }
    
    //bring the plus button to top
    [self bringSubviewToFront:self.plusButton];
}

#pragma mark -
#pragma mark - Private Methods

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    return NO;
}

// KVO监听执行
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(context != XYDTabBarContext) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
   
}

- (void)dealloc {
    // KVO反注册
    [self removeObserver:self forKeyPath:@"tabBarItemWidth"];
}

- (void)setTabBarItemWidth:(CGFloat )tabBarItemWidth {
    if (_tabBarItemWidth != tabBarItemWidth) {
        [self willChangeValueForKey:@"tabBarItemWidth"];
        _tabBarItemWidth = tabBarItemWidth;
        [self didChangeValueForKey:@"tabBarItemWidth"];
    }
}

- (void)setSwappableImageViewDefaultOffset:(CGFloat)swappableImageViewDefaultOffset {
    if (swappableImageViewDefaultOffset != 0.f) {
        [self willChangeValueForKey:@"swappableImageViewDefaultOffset"];
        _swappableImageViewDefaultOffset = swappableImageViewDefaultOffset;
        [self didChangeValueForKey:@"swappableImageViewDefaultOffset"];
    }
}

- (CGFloat)multiplerInCenterY {
    CGFloat multiplerInCenterY;
    if ([self.plusButton respondsToSelector:@selector(multiplerInCenterY)]) {
        multiplerInCenterY = [self.plusButton multiplerInCenterY];
    } else {
        CGSize sizeOfPlusButton = self.plusButton.frame.size;
        CGFloat heightDifference = sizeOfPlusButton.height - self.bounds.size.height;
        if (heightDifference < 0) {
            multiplerInCenterY = 0.5;
        } else {
            CGPoint center = CGPointMake(self.bounds.size.height * 0.5, self.bounds.size.height * 0.5);
            center.y = center.y - heightDifference * 0.5;
            multiplerInCenterY = center.y / self.bounds.size.height;
        }
    }
    return multiplerInCenterY;
}

- (NSUInteger)plusButtonIndex {
    NSUInteger plusButtonIndex;
    if ([self.plusButton respondsToSelector:@selector(indexOfPlusButtonInTabBar)]) {
        plusButtonIndex = [self.plusButton indexOfPlusButtonInTabBar];
    } else {
        if ([_tabBarController.viewControllers count] % 2 != 0) {
            [NSException raise:@"CYLTabBarController" format:@"If the count of CYLTabbarControllers is odd,you must realizse `+indexOfPlusButtonInTabBar` in your custom plusButton class.【Chinese】如果CYLTabbarControllers的个数是奇数，你必须在你自定义的plusButton中实现`+indexOfPlusButtonInTabBar`，来指定plusButton的位置"];
        }
        plusButtonIndex = [_tabBarController.viewControllers count] * 0.5;
    }
    return plusButtonIndex;
}

/*!
 *  Deal with some trickiness by Apple, You do not need to understand this method, somehow, it works.
 *  NOTE: If the `self.title of ViewController` and `the correct title of tabBarItemsAttributes` are different, Apple will delete the correct tabBarItem from subViews, and then trigger `-layoutSubviews`, therefore subViews will be in disorder. So we need to rearrange them.
 */
- (NSArray *)sortedSubviews {
    NSArray *sortedSubviews = [self.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView * formerView, UIView * latterView) {
        CGFloat formerViewX = formerView.frame.origin.x;
        CGFloat latterViewX = latterView.frame.origin.x;
        return  (formerViewX > latterViewX) ? NSOrderedDescending : NSOrderedAscending;
    }];
    return sortedSubviews;
}

- (NSArray *)tabBarButtonFromTabBarSubviews:(NSArray *)tabBarSubviews {
    NSMutableArray *tabBarButtonMutableArray = [NSMutableArray arrayWithCapacity:tabBarSubviews.count - 1];
    [tabBarSubviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonMutableArray addObject:obj];
        }
    }];
    if ([_plusButton plusChildViewController]) {
        [tabBarButtonMutableArray removeObjectAtIndex:[_plusButton indexOfPlusButtonInTabBar]];
    }
    return [tabBarButtonMutableArray copy];
}

- (void)setupSwappableImageViewDefaultOffset:(UIView *)tabBarButton {
    __block BOOL shouldCustomizeImageView = YES;
    __block CGFloat swappableImageViewHeight = 0.f;
    __block CGFloat swappableImageViewDefaultOffset = 0.f;
    CGFloat tabBarHeight = self.frame.size.height;
    [tabBarButton.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
            shouldCustomizeImageView = NO;
        }
        swappableImageViewHeight = obj.frame.size.height;
        BOOL isSwappableImageView = [obj isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")];
        if (isSwappableImageView) {
            swappableImageViewDefaultOffset = (tabBarHeight - swappableImageViewHeight) * 0.5 * 0.5;
        }
        if (isSwappableImageView && swappableImageViewDefaultOffset == 0.f) {
            shouldCustomizeImageView = NO;
        }
    }];
    if (shouldCustomizeImageView) {
        self.swappableImageViewDefaultOffset = swappableImageViewDefaultOffset;
    }
}

/*!
 *  Capturing touches on a subview outside the frame of its superview.
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    if (result) {
        return result;
    }
    for (UIView *subview in self.subviews.reverseObjectEnumerator) {
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        if (result) {
            return result;
        }
    }
    return nil;
}

@end
