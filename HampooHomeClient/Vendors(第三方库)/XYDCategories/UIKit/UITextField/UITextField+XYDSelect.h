//
//  UITextField+Select.h

//
//  Created by Jakey on 15/6/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (XYDSelect)
/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)xyd_selectedRange;
/**
 *  @brief  选中所有文字
 */
- (void)xyd_selectAllText;
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)xyd_setSelectedRange:(NSRange)range;
@end
