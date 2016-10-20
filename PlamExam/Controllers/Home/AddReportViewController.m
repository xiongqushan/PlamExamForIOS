//
//  AddReportViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "AddReportViewController.h"
#import "ReportModel.h"
#import "User.h"
#import "UserManager.h"
#import "CommonUtil.h"
#import "ReportManager.h"
@interface AddReportViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *addReportBtn;

@end

@implementation AddReportViewController
{
    User *_user;
}

- (IBAction)addReport:(id)sender {
    
    if (self.phoneNumTextField.text.length == 0) {
        [CommonUtil showHUDWithTitle:@"手机号不能为空"];
        return;
    }
    
    if (self.nameTextField.text.length == 0) {
        [CommonUtil showHUDWithTitle:@"姓名不能为空"];
        return;
    }
    
    MBProgressHUD *hud = [CommonUtil createHUD];
    [ReportModel addReport:_user.accountId withName:self.nameTextField.text withMobile:self.phoneNumTextField.text callBackBlock:^(HttpRequestResult<ReportBatch *> *httpRequestResult) {
        [hud hide:YES];
        if(httpRequestResult.IsSuccess){
            [[ReportManager shareInstance] setReportList:httpRequestResult.Data.Reports];
            if (self.reloadReportList) {
                self.reloadReportList(httpRequestResult.Data.Reports);
            }
            [CommonUtil showHUDWithTitle:@"添加成功"];
             [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [CommonUtil showHUDWithTitle:httpRequestResult.Message];
        }
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.addReportBtn setRound];
    
    _user = [[UserManager shareInstance] getUserInfo];
    
    self.phoneNumTextField.text = _user.mobile;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
