//
//  UITableViewCell+TS_delaysContentTouches.m
//  tableViewCellDelaysContentTouches
//
//  Created by Nicholas Hodapp on 1/31/14.
//  Copyright (c) 2014 Nicholas Hodapp. All rights reserved.
//

#import "UITableViewCell+XYDDelaysContentTouches.h"

@implementation UITableViewCell (XYDDelaysContentTouches)

- (UIScrollView*) xyd_scrollView
{
    id sv = self.contentView.superview;
    while ( ![sv isKindOfClass: [UIScrollView class]] && sv != self )
    {
        sv = [sv superview];
    }
    
    return sv == self ? nil : sv;
}

- (void) setXyd_delaysContentTouches:(BOOL)delaysContentTouches
{
    [self willChangeValueForKey: @"xyd_delaysContentTouches"];
    
    [[self xyd_scrollView] setDelaysContentTouches: delaysContentTouches];
    
    [self didChangeValueForKey: @"xyd_delaysContentTouches"];
}

- (BOOL) xyd_delaysContentTouches
{
    return [[self xyd_scrollView] delaysContentTouches];
}



@end
