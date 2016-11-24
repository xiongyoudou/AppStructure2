//
//  UIControl+XYDBlock.m
//  FXCategories
//
//  Created by fox softer on 15/2/23.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//

#import "UIControl+XYDBlock.h"
#import <objc/runtime.h>


// UIControlEventTouchDown           = 1 <<  0,      // on all touch downs
// UIControlEventTouchDownRepeat     = 1 <<  1,      // on multiple touchdowns
// (tap count > 1)
// UIControlEventTouchDragInside     = 1 <<  2,
// UIControlEventTouchDragOutside    = 1 <<  3,
// UIControlEventTouchDragEnter      = 1 <<  4,
// UIControlEventTouchDragExit       = 1 <<  5,
// UIControlEventTouchUpInside       = 1 <<  6,
// UIControlEventTouchUpOutside      = 1 <<  7,
// UIControlEventTouchCancel         = 1 <<  8,
//
// UIControlEventValueChanged        = 1 << 12,     // sliders, etc.
//
// UIControlEventEditingDidBegin     = 1 << 16,     // UITextField
// UIControlEventEditingChanged      = 1 << 17,
// UIControlEventEditingDidEnd       = 1 << 18,
// UIControlEventEditingDidEndOnExit = 1 << 19,     // 'return key' ending
// editing
//
// UIControlEventAllTouchEvents      = 0x00000FFF,  // for touch events
// UIControlEventAllEditingEvents    = 0x000F0000,  // for UITextField
// UIControlEventApplicationReserved = 0x0F000000,  // range available for
// application use
// UIControlEventSystemReserved      = 0xF0000000,  // range reserved for
// internal framework use
// UIControlEventAllEvents           = 0xFFFFFFFF

#define xyd_UICONTROL_EVENT(methodName, eventName)                                \
-(void)methodName : (void (^)(void))eventBlock {                              \
    objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);\
    [self addTarget:self                                                        \
    action:@selector(methodName##Action:)                                       \
    forControlEvents:UIControlEvent##eventName];                                \
}                                                                               \
-(void)methodName##Action:(id)sender {                                        \
    void (^block)() = objc_getAssociatedObject(self, @selector(methodName:));  \
    if (block) {                                                                \
        block();                                                                \
    }                                                                           \
}

@interface UIControl ()

@end

@implementation UIControl (XYDBlock)

xyd_UICONTROL_EVENT(xyd_touchDown, TouchDown)
xyd_UICONTROL_EVENT(xyd_touchDownRepeat, TouchDownRepeat)
xyd_UICONTROL_EVENT(xyd_touchDragInside, TouchDragInside)
xyd_UICONTROL_EVENT(xyd_touchDragOutside, TouchDragOutside)
xyd_UICONTROL_EVENT(xyd_touchDragEnter, TouchDragEnter)
xyd_UICONTROL_EVENT(xyd_touchDragExit, TouchDragExit)
xyd_UICONTROL_EVENT(xyd_touchUpInside, TouchUpInside)
xyd_UICONTROL_EVENT(xyd_touchUpOutside, TouchUpOutside)
xyd_UICONTROL_EVENT(xyd_touchCancel, TouchCancel)
xyd_UICONTROL_EVENT(xyd_valueChanged, ValueChanged)
xyd_UICONTROL_EVENT(xyd_editingDidBegin, EditingDidBegin)
xyd_UICONTROL_EVENT(xyd_editingChanged, EditingChanged)
xyd_UICONTROL_EVENT(xyd_editingDidEnd, EditingDidEnd)
xyd_UICONTROL_EVENT(xyd_editingDidEndOnExit, EditingDidEndOnExit)

//- (void)touchUpInside:(void (^)(void))eventBlock {
//   objc_setAssociatedObject(self, @selector(touchUpInside:, eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//  [self addTarget:self action:@selector(touchUpInsideAction:)
//  forControlEvents:UIControlEventTouchUpInside];
//}
//- (void)touchUpInsideAction:(id)sender {
//  void (^block)() = objc_getAssociatedObject(self, @selector(touchUpInsideAction:));
//  if (block) {
//    block();
//  }
//}

@end
