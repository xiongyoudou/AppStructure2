//
//  UIBarButtonItem+XYDAction.h

//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BarButtonJKActionBlock)();

@interface UIBarButtonItem (XYDAction)

/// A block that is run when the UIBarButtonItem is tapped.
//@property (nonatomic, copy) dispatch_block_t actionBlock;
- (void)setXyd_actionBlock:(BarButtonJKActionBlock)actionBlock;

@end
