//
//  UIButton+Block.h

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^XYDTouchedButtonBlock)(NSInteger tag);

@interface UIButton (XYDBlock)
-(void)xyd_addActionHandler:(XYDTouchedButtonBlock)touchHandler;
@end
