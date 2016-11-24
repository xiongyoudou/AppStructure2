//
//  XYDBottomBar.h
//  MiniPC
//
//  Created by xiongyoudou on 16/5/16.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AfterClickBarCell)(NSString *cellTitle);

@interface XYDBottomBar : UIView {
     NSArray *bottomBarDataArr;
}

@property (copy,nonatomic)AfterClickBarCell afterClickBarCell;
-(id)initWithBarDataArr:(NSArray *)barDataArr;

@end
