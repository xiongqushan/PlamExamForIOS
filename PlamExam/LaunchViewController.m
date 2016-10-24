//
//  LaunchViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "LaunchViewController.h"
#import "HZTabBarController.h"
#import "LoginViewController.h"
#import "UserManager.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(changeView) withObject:self afterDelay:2];
}

- (void)changeView {
    UIWindow *window = self.view.window;
    
    UIViewController *rootVc = [[HZTabBarController alloc] init];
    if (![[UserManager shareInstance] isLogin]) {
        rootVc = [[LoginViewController alloc] init];
    }
    
    //    //添加一个缩放效果
    //    rootVc.view.transform = CGAffineTransformMakeScale(0.4, 0.4);
    //    [UIView animateWithDuration:0.3 animations:^{
    //        rootVc.view.transform = CGAffineTransformIdentity;
    //    }];
    
    window.rootViewController = rootVc;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
