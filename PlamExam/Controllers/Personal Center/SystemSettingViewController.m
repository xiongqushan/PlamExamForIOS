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
#import "DoctorManager.h"
#import "ReportManager.h"
#import "FeedbackViewController.h"
#import "DisclaimerViewController.h"
#import <SDImageCache.h>

#define kAlertLoginOutTag 101
#define kAlertClearCacheTag 102

@interface SystemSettingViewController ()<UIAlertViewDelegate>

@end

@implementation SystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"系统设置";
    [self createItemData];

}

- (void) createItemData {
    User *user = [[UserManager shareInstance] getUserInfo];
    
    LabelItem *label0 = [LabelItem itemWithTitle:@"手机号码" subTitle:user.mobile withImage:[UIImage imageNamed:@"phone"]];
    GroupItem *group0 = [[GroupItem alloc] init];
    group0.items = @[label0];
    [self.dataArr addObject:group0];
    
    ArrowItem *arrow1 = [ArrowItem itemWithTitle:@"关于我们" withImage:[UIImage imageNamed:@"about"]];
    ArrowItem *arrow2 = [ArrowItem itemWithTitle:@"意见反馈" withImage:[UIImage imageNamed:@"feedback"]];
    arrow2.destVcClass = [FeedbackViewController class];
    ArrowItem *arrow3 = [ArrowItem itemWithTitle:@"检查更新" withImage:[UIImage imageNamed:@"checkUpdate"]];
    GroupItem *group1 = [[GroupItem alloc] init];
    group1.items = @[arrow1,arrow2,arrow3];
    [self.dataArr addObject:group1];
    
    ArrowItem *arrow4 = [ArrowItem itemWithTitle:@"免责声明" withImage:[UIImage imageNamed:@"disclaimer"]];
    arrow4.destVcClass = [DisclaimerViewController class];
    LabelItem *label = [LabelItem itemWithTitle:@"清理缓存" withImage:[UIImage imageNamed:@"clearCache"]];
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
    
    if (indexPath.section == 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = kAlertLoginOutTag;
        [alert show];
        
    }
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        //清理缓存
        double cacheSize = [self getCacheSize];
        NSString *message = [NSString stringWithFormat:@"清除%.2fM缓存？",cacheSize];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.tag = 102;
        [alert show];
    }
    
    GroupItem *group = self.dataArr[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    
    if (item.destVcClass) {
        UIViewController *vc = [[item.destVcClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == kAlertLoginOutTag) {
        //退出
        if (buttonIndex == alertView.cancelButtonIndex) {
            //取消
        }else {
            
            [[UserManager shareInstance] clearUserInfo];
            [[DoctorManager shareInstance] clearDoctorId];
            [[ReportManager shareInstance] clear];
            
            LoginViewController *login = [[LoginViewController alloc] init];
            [self presentViewController:login animated:YES completion:nil];
        }
    }else if (alertView.tag == kAlertClearCacheTag) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            
        }else {
            [self removeCacheSize];
        }
    }
}

- (double)getCacheSize {
    NSInteger fileSize = [[SDImageCache sharedImageCache] getSize];
    
    NSString *myCache = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/MyCaches"];
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:myCache error:nil];
    NSInteger myCacheSize = dict.fileSize;
    
    fileSize += myCacheSize;
    
    double cacheSize = fileSize/1024.0/1024.0;
    return cacheSize;
}

- (void)removeCacheSize {
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    NSString *myCache = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/MyCaches"];
    [[NSFileManager defaultManager] removeItemAtPath:myCache error:nil];
    
    [CommonUtil showHUDWithTitle:@"缓存清除成功!"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
