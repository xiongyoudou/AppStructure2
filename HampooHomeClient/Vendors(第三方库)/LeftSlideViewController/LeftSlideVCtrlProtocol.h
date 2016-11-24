//
//  LeftSlideVCtrlProtocol.h
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/21.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LeftSlideViewController;

@protocol LeftSideVCtrlProtocol <NSObject>

@property (nonatomic,weak)LeftSlideViewController *slideViewController;

@end

@protocol MainSideVCtrlProtocol <NSObject>

@property (nonatomic,weak)LeftSlideViewController *slideViewController;

@end
