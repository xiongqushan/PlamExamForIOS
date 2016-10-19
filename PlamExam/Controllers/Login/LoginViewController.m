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
#import "UserModel.h"
#import <YYModel.h>
#import <MBProgressHUD.h>

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
    
    MBProgressHUD *hud = [CommonUtil createHUD];
    
    [UserModel requestVerifyCode:self.phoneTextField.text CallbackDelegate:^(HttpRequestResult<NSString *> *httpResult) {
       // [hud hideAnimated:YES];

        [hud hide:YES];
        
        if (httpResult.IsHttpSuccess) {
            if (httpResult.HttpResult.Code == 1) {
                NSLog(@"______%@",httpResult.Data);
                [self.verCodeBtn startWithTime:30 title:@"获取验证码" countDownTitle:@"重新获取" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
            }else {
                [CommonUtil showHUDWithTitle:httpResult.HttpResult.Message];
            }
        }else {
            [CommonUtil showHUDWithTitle:httpResult.HttpMessage];
        }
    }];
    

    
}

//登录
- (IBAction)login:(id)sender {
    if (self.verCodeTextField.text.length == 0) {
        [CommonUtil showHUDWithTitle:@"请输入验证码"];
        return;
    }
   // [UserManager saveUserInfo];
    MBProgressHUD *hud = [CommonUtil createHUD];
    
    [UserModel requestLoginData:self.phoneTextField.text verifyCode:self.verCodeTextField.text callback:^(HttpRequestResult<User *> *httpResult) {

      //  [hud hideAnimated:YES];
        [hud hide:YES];
        
        if (httpResult.IsHttpSuccess) {
            if (httpResult.HttpResult.Code == 1) {
                
                User *user = httpResult.Data;
                [[UserManager shareInstance] saveUserInfo:user];
                
                HZTabBarController *tabBar = [[HZTabBarController alloc] init];
                [self presentViewController:tabBar animated:NO completion:nil];
            }else {
                [CommonUtil showHUDWithTitle:httpResult.HttpResult.Message];
            }
        }else {
            [CommonUtil showHUDWithTitle:httpResult.HttpMessage];
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //监听键盘显示通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //监听键盘收起的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHiden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)kbWillShow:(NSNotification *)note {
    
    if (kScreenSizeWidth < 375) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, -120);
        }];
    }

}

- (void)kbWillHiden:(NSNotification *)note {
    
    if (kScreenSizeWidth < 375) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }
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
