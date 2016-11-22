//
//  XYDBadgeButton.h
//  XYDTarbar
//
//  Created by xiong有都 on 16/6/30.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYDBadgeButton : UIButton

/**
 *  消息提醒：nil则不显示红点、length==0则只显示一个红点、length!=0则显示带有数目的红点
 */
@property (nonatomic, copy) NSString *badgeValue;

@end
