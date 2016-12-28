//
//  AwesomeMenuTool.h
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/23.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCPathButton.h"


@interface AwesomeMenuTool : NSObject<DCPathButtonDelegate>

- (void)configAwesomeMenuOnTabbarWithView:(UIView *)view;

@end
