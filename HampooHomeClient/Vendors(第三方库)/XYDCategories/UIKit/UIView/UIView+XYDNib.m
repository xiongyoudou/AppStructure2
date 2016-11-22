//
//  UIView+Nib.m

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+XYDNib.h"

@implementation UIView (XYDNib)
#pragma mark - Nibs
+ (UINib *)xyd_loadNib
{
    return [self xyd_loadNibNamed:NSStringFromClass([self class])];
}
+ (UINib *)xyd_loadNibNamed:(NSString*)nibName
{
    return [self xyd_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)xyd_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
    return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)xyd_loadInstanceFromNib
{
    return [self xyd_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)xyd_loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self xyd_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)xyd_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self xyd_loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)xyd_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}

@end
