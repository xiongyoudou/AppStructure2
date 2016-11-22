//
//  XYDBottomBar.m
//  MiniPC
//
//  Created by xiongyoudou on 16/5/16.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "XYDBottomBar.h"
#import "XYDBottomBarCell.h"

@implementation XYDBottomBar

-(id)initWithBarDataArr:(NSArray *)barDataArr {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        bottomBarDataArr = [NSArray arrayWithArray:barDataArr];
        CGSize cellSize = CGSizeMake(60, 40);
        CGFloat cellMargin = 5;
        if ((cellSize.width * barDataArr.count + (barDataArr.count - 1) * cellMargin) >=KWindowSize.width ) {
            cellMargin = (KWindowSize.width - cellSize.width * barDataArr.count) / (barDataArr.count - 1);
        }
        CGFloat cellSuperViewMargin = (KWindowSize.width - (cellSize.width * barDataArr.count) - (barDataArr.count - 1) * cellMargin) / 2.0;
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWindowSize.width, 1)];
        topView.backgroundColor = COLOR(218, 218, 218, 1);
        [self addSubview:topView];
        
        for (int i = 0;i<barDataArr.count;i++)
        {
            XYDBottomBarData *data = barDataArr[i];
            XYDBottomBarCell *cell = (XYDBottomBarCell *)[MyTool getNibViewByNibName:@"XYDBottomBarCell"];
            cell.tag = KTagDefine + i;
            [cell.backgroundBtn addTarget:self action:@selector(clickBarCell:) forControlEvents:UIControlEventTouchUpInside];
            [cell configWithBarData:data];
            CGRect cellFrame = CGRectMake(cellSuperViewMargin + i*(cellMargin + cellSize.width) , 4, cellSize.width, cellSize.height);
            cell.frame = cellFrame;
            [self addSubview:cell];
        }
    }
    return self;
}

-(void)clickBarCell:(id)sender {
    NSInteger tag = [(UIButton *)sender superview].tag;
    XYDBottomBarData *data = bottomBarDataArr[tag - KTagDefine];
    self.afterClickBarCell(data.title);
}

@end
