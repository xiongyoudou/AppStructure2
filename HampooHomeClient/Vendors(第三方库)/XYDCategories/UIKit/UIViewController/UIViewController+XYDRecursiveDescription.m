//
//  UIViewController+RecursiveDescription.m
//  HLiPad
//
//  Created by Richard Turton on 07/01/2013.
//
//

#import "UIViewController+XYDRecursiveDescription.h"

@implementation UIViewController (XYDRecursiveDescription)
/**
 *  @brief  视图层级
 *
 *  @return 视图层级字符串
 */
-(NSString*)xyd_recursiveDescription
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"\n"];
    [self xyd_addDescriptionToString:description indentLevel:0];
    return description;
}

-(void)xyd_addDescriptionToString:(NSMutableString*)string indentLevel:(NSInteger)indentLevel
{
    NSString *padding = [@"" stringByPaddingToLength:indentLevel withString:@" " startingAtIndex:0];
    [string appendString:padding];
    [string appendFormat:@"%@, %@",[self debugDescription],NSStringFromCGRect(self.view.frame)];

    for (UIViewController *childController in self.childViewControllers)
    {
        [string appendFormat:@"\n%@>",padding];
        [childController xyd_addDescriptionToString:string indentLevel:indentLevel + 1];
    }
}

@end
