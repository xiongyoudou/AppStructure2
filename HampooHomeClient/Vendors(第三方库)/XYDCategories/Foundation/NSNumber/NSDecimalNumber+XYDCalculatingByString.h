//
//  NSDecimalNumber+CalculatingByString.h
//  NSDecimalNumber+StringCalculation
//
//  Created by Adi Li on 11/5/14.
//  Copyright (c) 2014 Adi Li. All rights reserved.
//

//https://github.com/adi-li/NSDecimalNumber-StringCalculation
#import <Foundation/Foundation.h>

@interface NSDecimalNumber (XYDCalculatingByString)
/**
 *  @author XYDCategories
 *
 *   use string calculation for nsdecimalnumber, for simplicity when doing much calculation works. 
 *
 *  @param equation <#equation description#>
 *  @param numbers  <#numbers description#>
 *
 *  @return <#return value description#>
 */
+ (NSDecimalNumber *)xyd_decimalNumberWithEquation:(NSString *)equation decimalNumbers:(NSDictionary *)numbers;
@end
