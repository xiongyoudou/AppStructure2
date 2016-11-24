//
//  NSIndexPath+Offset.h
//
//  Created by Nicolas Goutaland on 04/04/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface NSIndexPath (XYDOffset)
/**
 *  @author XYDCategories
 *
 *  Compute previous row indexpath
 *
 */
- (NSIndexPath *)xyd_previousRow;
/**
 *  @author XYDCategories
 *
 *  Compute next row indexpath
 *
 */
- (NSIndexPath *)xyd_nextRow;
/**
 *  @author XYDCategories
 *
 *  Compute previous item indexpath
 *
 */
- (NSIndexPath *)xyd_previousItem;
/**
 *  @author XYDCategories
 *
 *  Compute next item indexpath
 *
 */
- (NSIndexPath *)xyd_nextItem;
/**
 *  @author XYDCategories
 *
 *  Compute next section indexpath
 *
 */
- (NSIndexPath *)xyd_nextSection;
/**
 *  @author XYDCategories
 *
 *  Compute previous section indexpath
 *
 */
- (NSIndexPath *)xyd_previousSection;

@end
