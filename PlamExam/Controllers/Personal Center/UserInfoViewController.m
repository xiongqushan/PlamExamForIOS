//
//  UserInfoViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "UserInfoViewController.h"
#import "BaseSetting.h"
#import "IconCell.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人资料";
    
    [self createItemsData];

}

- (void)createItemsData {
    
    SettingItem *set = [SettingItem itemWithTitle:nil];
    LabelItem *label = [LabelItem itemWithTitle:@"姓名" subTitle:@"倩倩" withImage:nil];
    LabelItem *label2 = [LabelItem itemWithTitle:@"手机号" subTitle:@"15601818531" withImage:nil];
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[set,label,label2];
    [self.dataArr addObject:group];
    
    LabelItem *label3 = [LabelItem itemWithTitle:@"实名认证" subTitle:@"未认证" withImage:nil];
    GroupItem *group2 = [[GroupItem alloc] init];
    group2.items = @[label3];
    [self.dataArr addObject:group2];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString *cellId = @"IconCell";
        IconCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"IconCell" owner:self options:nil] lastObject];
        }
        return cell;
    }else {
        GroupItem *group = self.dataArr[indexPath.section];
        SettingItem *item = group.items[indexPath.row];
        
        SettingCell *cell = [SettingCell cellWithTableView:tableView];
        cell.item = item;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        return 50;
//    }else {
//        return 44;
//    }
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
