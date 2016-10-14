//
//  BaseSettingViewController.m
//  Health
//
//  Created by 郭凯 on 16/5/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BaseSettingViewController.h"
#import "BaseSetting.h"
#import "SettingCell.h"

@interface BaseSettingViewController () <UIAlertViewDelegate>

@end

@implementation BaseSettingViewController

- (instancetype)init {
    //self.tableView.backgroundColor = kSetRGBColor(246, 246, 246);
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GroupItem *group = self.dataArr[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupItem *group = self.dataArr[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    cell.item = item;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    GroupItem *group = self.dataArr[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    
    if (item.destVcClass) {
        UIViewController *vc = [[item.destVcClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

//设置tableView的分区头视图高度和分区尾视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenSizeWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenSizeWidth, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = kSetRGBColor(246, 246, 246);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
