//
//  UIButton+Block.m

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIButton+XYDBlock.h"
#import <objc/runtime.h>
static const void *xyd_UIButtonBlockKey = &xyd_UIButtonBlockKey;

@implementation UIButton (xyd_Block)
-(void)xyd_addActionHandler:(XYDTouchedButtonBlock)touchHandler{
    objc_setAssociatedObject(self, xyd_UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(xyd_blockActionTouched:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)xyd_blockActionTouched:(UIButton *)btn{
    XYDTouchedButtonBlock block = objc_getAssociatedObject(self, xyd_UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}
@end

