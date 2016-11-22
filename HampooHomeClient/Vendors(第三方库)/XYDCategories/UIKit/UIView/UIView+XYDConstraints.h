//
//  UIView+XYDConstraints.h

//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYDConstraints)
- (NSLayoutConstraint *)xyd_constraintForAttribute:(NSLayoutAttribute)attribute;

- (NSLayoutConstraint *)xyd_leftConstraint;
- (NSLayoutConstraint *)xyd_rightConstraint;
- (NSLayoutConstraint *)xyd_topConstraint;
- (NSLayoutConstraint *)xyd_bottomConstraint;
- (NSLayoutConstraint *)xyd_leadingConstraint;
- (NSLayoutConstraint *)xyd_trailingConstraint;
- (NSLayoutConstraint *)xyd_widthConstraint;
- (NSLayoutConstraint *)xyd_heightConstraint;
- (NSLayoutConstraint *)xyd_centerXConstraint;
- (NSLayoutConstraint *)xyd_centerYConstraint;
- (NSLayoutConstraint *)xyd_baseLineConstraint;
@end
