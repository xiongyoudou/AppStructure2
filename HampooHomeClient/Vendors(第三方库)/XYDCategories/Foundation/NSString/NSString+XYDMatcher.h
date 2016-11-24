//
//  NSString+XYDMatcher.h
//  Whyd
//
//  Created by Damien Romito on 29/01/15.
//  Copyright (c) 2015 Damien Romito. All rights reserved.
//
//https://github.com/damienromito/NSString-Matcher
#import <Foundation/Foundation.h>
@interface NSString(XYDMatcher)
- (NSArray *)xyd_matchWithRegex:(NSString *)regex;
- (NSString *)xyd_matchWithRegex:(NSString *)regex atIndex:(NSUInteger)index;
- (NSString *)xyd_firstMatchedGroupWithRegex:(NSString *)regex;
- (NSTextCheckingResult *)xyd_firstMatchedResultWithRegex:(NSString *)regex;
@end
