//
//  SelectOptionVCtrl.m
//  HampooHomeClient
//
//  Created by xiongyoudou on 2016/11/22.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "SelectOptionVCtrl.h"

@interface SelectOptionVCtrl ()

@end

@implementation SelectOptionVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    [self.tableView setSeparatorColor:COLOR(90, 90, 92, 1)];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.textLabel.text = dict[@"text"];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:dict[@"imageName"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = COLOR(47,53,53,1);
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = COLOR(65, 65, 67, 1);
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end
