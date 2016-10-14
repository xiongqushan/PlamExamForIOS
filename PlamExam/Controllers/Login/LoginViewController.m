//
//  LoginViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#define kGetVrCodeURL @"http://hz75thbd2:803/api/v1_User/LoginSMSCode"
#import "LoginViewController.h"
#import "UIButton+countDown.h"
#import "CommonUtil.h"
#import "HZTabBarController.h"
#import "UserManager.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *verCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation LoginViewController
//获取验证码
- (IBAction)getVerCodeClick:(id)sender {
    //验证是否为正确的手机号
    BOOL isPhoneNumber = [CommonUtil isPhoneNumber:self.phoneTextField.text];
    if (!isPhoneNumber) {
        [CommonUtil showHUDWithTitle:@"请输入正确的手机号"];
        return;
    }
    
    [self.verCodeBtn startWithTime:30 title:@"获取验证码" countDownTitle:@"重新获取" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
    
}

//登录
- (IBAction)login:(id)sender {
    if (self.verCodeTextField.text.length == 0) {
        [CommonUtil showHUDWithTitle:@"请输入验证码"];
        return;
    }
    [UserManager saveUserInfo];
    
    HZTabBarController *tabBar = [[HZTabBarController alloc] init];
    [self presentViewController:tabBar animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.logoImageView setRound];
    [self.loginBtn setRound];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneTextField resignFirstResponder];
    [self.verCodeTextField resignFirstResponder];
}

- (void)dealloc {
    NSLog(@"________dealloc!!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
