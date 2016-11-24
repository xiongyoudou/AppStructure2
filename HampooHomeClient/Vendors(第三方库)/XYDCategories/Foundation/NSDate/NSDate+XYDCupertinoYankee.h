// NSDate+CupertinoYankee.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

/**
 
 */
@interface NSDate (XYDCupertinoYankee)

///---------------------------------------
/// @name Calculate Beginning / End of Day
///---------------------------------------

/**
 
 */
- (NSDate *)xyd_beginningOfDay;

/**
 
 */
- (NSDate *)xyd_endOfDay;

///----------------------------------------
/// @name Calculate Beginning / End of Week
///----------------------------------------

/**
 
 */
- (NSDate *)xyd_beginningOfWeek;

/**
 
 */
- (NSDate *)xyd_endOfWeek;

///-----------------------------------------
/// @name Calculate Beginning / End of Month
///-----------------------------------------

/**
 
 */
- (NSDate *)xyd_beginningOfMonth;

/**
 
 */
- (NSDate *)xyd_endOfMonth;

///----------------------------------------
/// @name Calculate Beginning / End of Year
///----------------------------------------

/**
 
 */
- (NSDate *)xyd_beginningOfYear;

/**
 
 */
- (NSDate *)xyd_endOfYear;

@end
