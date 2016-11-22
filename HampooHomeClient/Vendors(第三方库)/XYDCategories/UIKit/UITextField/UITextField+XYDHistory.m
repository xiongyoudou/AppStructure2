//
//  UITextField+History.m
//  Demo
//
//  Created by DamonDing on 15/5/26.
//  Copyright (c) 2015年 morenotepad. All rights reserved.
//

#import "UITextField+XYDHistory.h"
#import <objc/runtime.h>

#define xyd_history_X(view) (view.frame.origin.x)
#define xyd_history_Y(view) (view.frame.origin.y)
#define xyd_history_W(view) (view.frame.size.width)
#define xyd_history_H(view) (view.frame.size.height)

static char kTextFieldIdentifyKey;
static char kTextFieldHistoryviewIdentifyKey;

#define xyd_ANIMATION_DURATION 0.3f
#define xyd_ITEM_HEIGHT 40
#define xyd_CLEAR_BUTTON_HEIGHT 45
#define xyd_MAX_HEIGHT 300


@interface UITextField ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *xyd_historyTableView;

@end


@implementation UITextField (XYDHistory)

- (NSString*)xyd_identify {
    return objc_getAssociatedObject(self, &kTextFieldIdentifyKey);
}

- (void)setXyd_identify:(NSString *)identify {
    objc_setAssociatedObject(self, &kTextFieldIdentifyKey, identify, OBJC_ASSOCIATION_RETAIN);
}

- (UITableView*)xyd_historyTableView {
    UITableView* table = objc_getAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey);
    
    if (table == nil) {
        table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITextFieldHistoryCell"];
        table.layer.borderColor = [UIColor grayColor].CGColor;
        table.layer.borderWidth = 1;
        table.delegate = self;
        table.dataSource = self;
        objc_setAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey, table, OBJC_ASSOCIATION_RETAIN);
    }
    
    return table;
}

- (NSArray*)xyd_loadHistroy {
    if (self.xyd_identify == nil) {
        return nil;
    }

    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+XYDHistory"];
    
    if (dic != nil) {
        return [dic objectForKey:self.xyd_identify];
    }

    return nil;
}

- (void)xyd_synchronize {
    if (self.xyd_identify == nil || [self.text length] == 0) {
        return;
    }
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+XYDHistory"];
    NSArray* history = [dic objectForKey:self.xyd_identify];
    
    NSMutableArray* newHistory = [NSMutableArray arrayWithArray:history];
    
    __block BOOL haveSameRecord = false;
    __weak typeof(self) weakSelf = self;
    
    [newHistory enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NSString*)obj isEqualToString:weakSelf.text]) {
            *stop = true;
            haveSameRecord = true;
        }
    }];
    
    if (haveSameRecord) {
        return;
    }
    
    [newHistory addObject:self.text];
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:newHistory forKey:self.xyd_identify];
    
    [def setObject:dic2 forKey:@"UITextField+XYDHistory"];
    
    [def synchronize];
}

- (void) xyd_showHistory; {
    NSArray* history = [self xyd_loadHistroy];
    
    if (self.xyd_historyTableView.superview != nil || history == nil || history.count == 0) {
        return;
    }
    
    CGRect frame1 = CGRectMake(xyd_history_X(self), xyd_history_Y(self) + xyd_history_H(self) + 1, xyd_history_W(self), 1);
    CGRect frame2 = CGRectMake(xyd_history_X(self), xyd_history_Y(self) + xyd_history_H(self) + 1, xyd_history_W(self), MIN(xyd_MAX_HEIGHT, xyd_ITEM_HEIGHT * history.count + xyd_CLEAR_BUTTON_HEIGHT));
    
    self.xyd_historyTableView.frame = frame1;
    
    [self.superview addSubview:self.xyd_historyTableView];
    
    [UIView animateWithDuration:xyd_ANIMATION_DURATION animations:^{
        self.xyd_historyTableView.frame = frame2;
    }];
}

- (void) xyd_clearHistoryButtonClick:(UIButton*) button {
    [self xyd_clearHistory];
    [self xyd_hideHistroy];
}

- (void)xyd_hideHistroy; {
    if (self.xyd_historyTableView.superview == nil) {
        return;
    }

    CGRect frame1 = CGRectMake(xyd_history_X(self), xyd_history_Y(self) + xyd_history_H(self) + 1, xyd_history_W(self), 1);
    
    [UIView animateWithDuration:xyd_ANIMATION_DURATION animations:^{
        self.xyd_historyTableView.frame = frame1;
    } completion:^(BOOL finished) {
        [self.xyd_historyTableView removeFromSuperview];
    }];
}

- (void) xyd_clearHistory; {
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:nil forKey:@"UITextField+XYDHistory"];
    [def synchronize];
}


#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
    return [self xyd_loadHistroy].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITextFieldHistoryCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITextFieldHistoryCell"];
    }
    
    cell.textLabel.text = [self xyd_loadHistroy][indexPath.row];
    
    return cell;
}

#pragma mark tableview delegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section; {
    UIButton* clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(xyd_clearHistoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return clearButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
    return xyd_ITEM_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    return xyd_CLEAR_BUTTON_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
    self.text = [self xyd_loadHistroy][indexPath.row];
    [self xyd_hideHistroy];
}

@end
