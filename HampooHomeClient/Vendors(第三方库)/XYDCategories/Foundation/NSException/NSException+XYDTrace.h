//
//  NSException+Trace.h

//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSException (XYDTrace)
- (NSArray *)xyd_backtrace;
@end
