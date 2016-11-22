//
//  UITableViewCell+NIB.m

//
//  Created by Jakey on 14/11/19.
//  Copyright (c) 2014年 jakey. All rights reserved.
//

#import "UITableViewCell+XYDNIB.h"

@implementation UITableViewCell (XYDNIB)
/**
 *  @brief  加载同类名的nib
 *
 *  @return nib
 */
+(UINib*)xyd_nib{
   return  [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}
@end
