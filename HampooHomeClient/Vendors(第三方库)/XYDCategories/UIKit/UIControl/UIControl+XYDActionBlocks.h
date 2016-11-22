//
//  UIControl+XYDActionBlocks.h

//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  https://github.com/lavoy/ALActionBlocks

#import <UIKit/UIKit.h>
typedef void (^UIControlJKActionBlock)(id weakSender);


@interface UIControlJKActionBlockWrapper : NSObject
@property (nonatomic, copy) UIControlJKActionBlock xyd_actionBlock;
@property (nonatomic, assign) UIControlEvents xyd_controlEvents;
- (void)xyd_invokeBlock:(id)sender;
@end



@interface UIControl (XYDActionBlocks)
- (void)xyd_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlJKActionBlock)actionBlock;
- (void)xyd_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents;
@end
