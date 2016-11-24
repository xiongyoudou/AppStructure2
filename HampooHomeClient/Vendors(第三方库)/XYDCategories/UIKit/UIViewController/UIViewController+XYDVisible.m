//
//  UIViewController+XYDVisible.m

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIViewController+XYDVisible.h"

@implementation UIViewController (XYDVisible)
- (BOOL)xyd_isVisible {
    return [self isViewLoaded] && self.view.window;
}
@end
