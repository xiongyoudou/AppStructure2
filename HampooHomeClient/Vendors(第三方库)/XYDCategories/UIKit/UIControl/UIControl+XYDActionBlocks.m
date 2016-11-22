//
//  UIControl+XYDActionBlocks.m

//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIControl+XYDActionBlocks.h"
#import <objc/runtime.h>

static const void *UIControlJKActionBlockArray = &UIControlJKActionBlockArray;

@implementation UIControlJKActionBlockWrapper

- (void)xyd_invokeBlock:(id)sender {
    if (self.xyd_actionBlock) {
        self.xyd_actionBlock(sender);
    }
}
@end


@implementation UIControl (XYDActionBlocks)
-(void)xyd_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlJKActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self xyd_actionBlocksArray];
    
    UIControlJKActionBlockWrapper *blockActionWrapper = [[UIControlJKActionBlockWrapper alloc] init];
    blockActionWrapper.xyd_actionBlock = actionBlock;
    blockActionWrapper.xyd_controlEvents = controlEvents;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self addTarget:blockActionWrapper action:@selector(xyd_invokeBlock:) forControlEvents:controlEvents];
}


- (void)xyd_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableArray *actionBlocksArray = [self xyd_actionBlocksArray];
    NSMutableArray *wrappersToRemove = [NSMutableArray arrayWithCapacity:[actionBlocksArray count]];
    
    [actionBlocksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIControlJKActionBlockWrapper *wrapperTmp = obj;
        if (wrapperTmp.xyd_controlEvents == controlEvents) {
            [wrappersToRemove addObject:wrapperTmp];
            [self removeTarget:wrapperTmp action:@selector(xyd_invokeBlock:) forControlEvents:controlEvents];
        }
    }];
    
    [actionBlocksArray removeObjectsInArray:wrappersToRemove];
}


- (NSMutableArray *)xyd_actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, UIControlJKActionBlockArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, UIControlJKActionBlockArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}
@end
