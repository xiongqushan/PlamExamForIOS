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

@interface SystemSettingViewController ()

@end

@implementation SystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"系统设置";
    
    UIButton *loginOut = [UIButton buttonWithType:UIButtonTypeCustom];
    loginOut.frame = CGRectMake(100, 100, kScreenSizeWidth - 200, 30);
    [loginOut setTitle:@"退出" forState:UIControlStateNormal];
    [loginOut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [loginOut addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginOut];
}

- (void)loginOut {
    [UserManager clearUserInfo];
    LoginViewController *login = [[LoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

- (void) createItemData {
    ArrowItem *arrow1 = [ArrowItem itemWithTitle:@"关于我们"];
    ArrowItem *arrow2 = [ArrowItem itemWithTitle:@"意见反馈"];
    ArrowItem *arrow3 = [ArrowItem itemWithTitle:@"检查更新"];
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[arrow1,arrow2,arrow3];
    [self.dataArr addObject:group];
    
    ArrowItem *arrow4 = [ArrowItem itemWithTitle:@"免责声明"];
    LabelItem *label = [LabelItem itemWithTitle:@"清理缓存"];
    GroupItem *group2 = [[GroupItem alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
