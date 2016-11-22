//
//  RoundPlusPathBtn.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/22.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "RoundPlusPathBtn.h"

@interface RoundPlusPathBtn ()<DCPathButtonDelegate>

@end

@implementation RoundPlusPathBtn
@synthesize btnSelected = _btnSelected;


+ (id)getInstance {
    RoundPlusPathBtn *btn = [[RoundPlusPathBtn alloc] initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"] highlightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    if (btn) {
        btn = [btn plusButton];
    }
    return btn;
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
- (id)plusButton {
    self.delegate = self;
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];
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
    [self addPathItems:@[itemButton_1,
                                 itemButton_2,
                                 itemButton_3,
                                 itemButton_4,
                                 itemButton_5
                                 ]];
    
    // Change the bloom radius, default is 105.0f
    self.bloomRadius = 120.0f;
    self.allowSounds = YES;
    self.allowCenterButtonRotation = YES;
    self.bottomViewColor = [UIColor blackColor];
    self.bloomDirection = kDCPathButtonBloomDirectionTop;
        
    return self;
}

- (void)plusChildViewControllerButtonClicked:(UIButton<XYDPlusButtonProtocol> *)sender {
    sender.btnSelected = YES;
}

- (CGFloat)plusButtonWidth {
    CGFloat width =  self.frame.size.width;
    return width;
}

- (void)setBtnSelected:(BOOL)btnSelected {
    _btnSelected = btnSelected;
}

- (BOOL)btnSelected {
    return _btnSelected;
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    self.btnSelected = !self.btnSelected;
    NSLog(@"点击按钮");
}

#pragma mark - CYLPlusButtonSubclassing

- (UIViewController *)plusChildViewController {
    return nil;
}

- (NSUInteger)indexOfPlusButtonInTabBar {
    return 1;
}

- (CGFloat)multiplerInCenterY {
    return  0.5;
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

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@",change);
}

@end
