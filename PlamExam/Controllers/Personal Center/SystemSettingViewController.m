//
//  SystemSettingViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SystemSettingViewController.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import "BaseSetting.h"
#import "User.h"
#import "UserManager.h"

@interface SystemSettingViewController ()

@end

@implementation SystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"系统设置";
    [self createItemData];

}

- (void) createItemData {
    User *user = [[UserManager shareInstance] getUserInfo];
    
    LabelItem *label0 = [LabelItem itemWithTitle:@"手机号码" subTitle:user.mobile withImage:nil];
    GroupItem *group0 = [[GroupItem alloc] init];
    group0.items = @[label0];
    [self.dataArr addObject:group0];
    
    ArrowItem *arrow1 = [ArrowItem itemWithTitle:@"关于我们"];
    ArrowItem *arrow2 = [ArrowItem itemWithTitle:@"意见反馈"];
    ArrowItem *arrow3 = [ArrowItem itemWithTitle:@"检查更新"];
    GroupItem *group1 = [[GroupItem alloc] init];
    group1.items = @[arrow1,arrow2,arrow3];
    [self.dataArr addObject:group1];
    
    ArrowItem *arrow4 = [ArrowItem itemWithTitle:@"免责声明"];
    LabelItem *label = [LabelItem itemWithTitle:@"清理缓存"];
    GroupItem *group2 = [[GroupItem alloc] init];
    group2.items = @[arrow4, label];
    [self.dataArr addObject:group2];
    
    LabelItem *label2 = [[LabelItem alloc] init];
    label2.titleText = @"退出登录";
    GroupItem *group3 = [[GroupItem alloc] init];
    group3.items = @[label2];
    [self.dataArr addObject:group3];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        //退出登录
        [[UserManager shareInstance] clearUserInfo];
        LoginViewController *login = [[LoginViewController alloc] init];
        [self presentViewController:login animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
