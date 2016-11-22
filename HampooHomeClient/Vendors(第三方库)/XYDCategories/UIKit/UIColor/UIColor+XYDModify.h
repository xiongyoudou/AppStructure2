//
//  UIColor+Modify.h

//
//  Created by Jakey on 15/1/2.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XYDModify)
- (UIColor *)xyd_invertedColor;
- (UIColor *)xyd_colorForTranslucency;
- (UIColor *)xyd_lightenColor:(CGFloat)lighten;
- (UIColor *)xyd_darkenColor:(CGFloat)darken;
@end
