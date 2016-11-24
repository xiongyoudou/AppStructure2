//
//  UITextField+Blocks.h

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UITextField (XYDBlocks)
@property (copy, nonatomic) BOOL (^xyd_shouldBegindEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^xyd_shouldEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^xyd_didBeginEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^xyd_didEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^xyd_shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);
@property (copy, nonatomic) BOOL (^xyd_shouldReturnBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^xyd_shouldClearBlock)(UITextField *textField);

- (void)setXyd_shouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock;
- (void)setXyd_shouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
- (void)setXyd_didBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;
- (void)setXyd_didEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
- (void)setXyd_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
- (void)setXyd_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
- (void)setXyd_shouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;
@end
