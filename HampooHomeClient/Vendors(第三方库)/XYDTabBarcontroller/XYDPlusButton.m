//
//  XYDPlusButton.m
//  XYDTarbar
//
//  Created by xiong有都 on 16/6/25.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "XYDPlusButton.h"
#import "XYDTabBarController.h"


@implementation XYDPlusButton

#pragma mark -
#pragma mark - public Methods

- (void)plusChildViewControllerButtonClicked:(UIButton<XYDPlusButtonProtocol> *)sender {
    sender.selected = YES;
}

- (CGFloat)plusButtonWidth {
    return self.frame.size.width;
}



#pragma mark -
#pragma mark - Private Methods

+ (void)addSelectViewControllerTarget:(UIButton<XYDPlusButtonProtocol> *)plusButton {
    id target = self;
    NSArray<NSString *> *selectorNamesArray = [plusButton actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];
    if (selectorNamesArray.count == 0) {
        target = plusButton;
        selectorNamesArray = [plusButton actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];
    }
    [selectorNamesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEL selector =  NSSelectorFromString(obj);
        [plusButton removeTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }];
    [plusButton addTarget:plusButton action:@selector(plusChildViewControllerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}


@end
