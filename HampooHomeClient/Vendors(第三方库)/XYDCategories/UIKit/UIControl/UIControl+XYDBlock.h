//
//  UIControl+XYDBlock.h
//  FXCategories
//
//  Created by fox softer on 15/2/23.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//  https://github.com/foxsofter/FXCategories
//  http://stackoverflow.com/questions/2437875/target-action-uicontrolevents
#import <UIKit/UIKit.h>

@interface UIControl (XYDBlock)

- (void)xyd_touchDown:(void (^)(void))eventBlock;
- (void)xyd_touchDownRepeat:(void (^)(void))eventBlock;
- (void)xyd_touchDragInside:(void (^)(void))eventBlock;
- (void)xyd_touchDragOutside:(void (^)(void))eventBlock;
- (void)xyd_touchDragEnter:(void (^)(void))eventBlock;
- (void)xyd_touchDragExit:(void (^)(void))eventBlock;
- (void)xyd_touchUpInside:(void (^)(void))eventBlock;
- (void)xyd_touchUpOutside:(void (^)(void))eventBlock;
- (void)xyd_touchCancel:(void (^)(void))eventBlock;
- (void)xyd_valueChanged:(void (^)(void))eventBlock;
- (void)xyd_editingDidBegin:(void (^)(void))eventBlock;
- (void)xyd_editingChanged:(void (^)(void))eventBlock;
- (void)xyd_editingDidEnd:(void (^)(void))eventBlock;
- (void)xyd_editingDidEndOnExit:(void (^)(void))eventBlock;

@end
