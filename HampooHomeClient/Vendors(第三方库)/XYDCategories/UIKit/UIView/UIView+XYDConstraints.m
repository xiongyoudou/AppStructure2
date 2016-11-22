//
//  UIView+XYDConstraints.m

//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIView+XYDConstraints.h"

@implementation UIView (XYDConstraints)
-(NSLayoutConstraint *)xyd_constraintForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && (firstItem = %@ || secondItem = %@)", attribute, self, self];
    NSArray *constraintArray = [self.superview constraints];
    
    if (attribute == NSLayoutAttributeWidth || attribute == NSLayoutAttributeHeight) {
        constraintArray = [self constraints];
    }
    
    NSArray *fillteredArray = [constraintArray filteredArrayUsingPredicate:predicate];
    if(fillteredArray.count == 0) {
        return nil;
    } else {
        return fillteredArray.firstObject;
    }
}

- (NSLayoutConstraint *)xyd_leftConstraint {
    return [self xyd_constraintForAttribute:NSLayoutAttributeLeft];
}

- (NSLayoutConstraint *)xyd_rightConstraint {
    return [self xyd_constraintForAttribute:NSLayoutAttributeRight];
}

- (NSLayoutConstraint *)xyd_topConstraint {
    return [self xyd_constraintForAttribute:NSLayoutAttributeTop];
}

- (NSLayoutConstraint *)xyd_bottomConstraint {
    return [self xyd_constraintForAttribute:NSLayoutAttributeBottom];
}

- (NSLayoutConstraint *)xyd_leadingConstraint {
    return [self xyd_constraintForAttribute:NSLayoutAttributeLeading];
}

- (NSLayoutConstraint *)xyd_trailingConstraint {
    return [self xyd_constraintForAttribute:NSLayoutAttributeTrailing];
}

- (NSLayoutConstraint *)xyd_widthConstraint {
    return [self xyd_constraintForAttribute:NSLayoutAttributeWidth];
}

- (NSLayoutConstraint *)xyd_heightConstraint {
    return [self xyd_constraintForAttribute:NSLayoutAttributeHeight];
}

- (NSLayoutConstraint *)xyd_centerXConstraint {
    return [self xyd_constraintForAttribute:NSLayoutAttributeCenterX];
}

- (NSLayoutConstraint *)xyd_centerYConstraint {
    return [self xyd_constraintForAttribute:NSLayoutAttributeCenterY];
}

- (NSLayoutConstraint *)xyd_baseLineConstraint {
    return [self xyd_constraintForAttribute:NSLayoutAttributeBaseline];
}
@end
