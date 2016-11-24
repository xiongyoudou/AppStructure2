//
//  UIView+Nib.h

//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (XYDNib)
+ (UINib *)xyd_loadNib;
+ (UINib *)xyd_loadNibNamed:(NSString*)nibName;
+ (UINib *)xyd_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;

+ (instancetype)xyd_loadInstanceFromNib;
+ (instancetype)xyd_loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)xyd_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)xyd_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;

@end
