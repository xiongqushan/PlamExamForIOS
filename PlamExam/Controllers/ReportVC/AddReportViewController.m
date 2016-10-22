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
#import "UserManager.h"
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
            NSArray<ReportSimple*>*reports=httpRequestResult.Data.Reports;
            if(!reports){
                reports=[[NSArray<ReportSimple*> alloc] init];
            }
            
            [[ReportManager shareInstance] setReportList:reports];
            if(![[[UserManager shareInstance] getUserInfo].departId isEqual:httpRequestResult.Data.CheckUnitCode]){
                User *user= [[UserManager shareInstance] getUserInfo];
                user.departId=httpRequestResult.Data.CheckUnitCode;
                user.departName=httpRequestResult.Data.DepartName;
                [[UserManager shareInstance] setUserInfo:user];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kChangeDepartKVOKey object:nil];
            }
            if (self.reloadReportList) {
                self.reloadReportList(httpRequestResult.Data.Reports);
            }
            NSString *notice=@"添加成功！";
            if([reports count]==0){
                notice=@"未能找到体检报告！";
            }
            [CommonUtil showHUDWithTitle:notice];
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
