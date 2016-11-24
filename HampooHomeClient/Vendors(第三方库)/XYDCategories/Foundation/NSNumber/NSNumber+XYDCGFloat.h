
//
//  NSNumber+CGFloat.h
//
//  Created by Alexey Aleshkov on 16.02.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSNumber (XYDCGFloat)

- (CGFloat)xyd_CGFloatValue;

- (id)initWithJKCGFloat:(CGFloat)value;

+ (NSNumber *)xyd_numberWithCGFloat:(CGFloat)value;

@end
