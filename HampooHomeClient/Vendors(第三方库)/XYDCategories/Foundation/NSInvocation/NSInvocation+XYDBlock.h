//
//  NSInvocation+Block.h
//  NSInvocation+Block
//
//  Created by deput on 12/11/15.
//  Copyright © 2015 deput. All rights reserved.
//
// NSInvocation category to create NSInvocation with block
//https://github.com/deput/NSInvocation-Block
#import <Foundation/Foundation.h>

@interface NSInvocation (XYDBlock)
+ (instancetype)xyd_invocationWithBlock:(id) block;
+ (instancetype)xyd_invocationWithBlockAndArguments:(id) block ,...;
@end
