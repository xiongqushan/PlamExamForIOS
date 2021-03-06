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
#import "UIColor+Utils.h"

@interface AddReportViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *addReportBtn;

@end

@implementation AddReportViewController
{
    User *_user;
}

- (IBAction)textFieldDidChange:(id)sender {
    
    if (self.nameTextField.text.length >= 15) {
        self.nameTextField.text = [self.nameTextField.text substringToIndex:15];
    }
    
    if (self.nameTextField.text.length < 2) {
        self.addReportBtn.enabled = NO;
        self.addReportBtn.backgroundColor = [UIColor lightGrayColor];
    }else {
        self.addReportBtn.enabled = YES;
        self.addReportBtn.backgroundColor = [UIColor navigationBarColor];
    }
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
        hud.hidden = YES;
        if(httpRequestResult.IsSuccess){
            
            NSArray<ReportSimple*>*reports=httpRequestResult.Data.Reports;
            if(!reports){
                reports=[[NSArray<ReportSimple*> alloc] init];
            }
        
            [[ReportManager shareInstance] setReportList:reports];
            if([reports count]>0){
                NSString *newReportId=[reports lastObject].CheckUnitCode;
                if(![[[UserManager shareInstance] getUserInfo].departId isEqualToString:newReportId]){
                    User *user= [[UserManager shareInstance] getUserInfo];
                    user.departId=httpRequestResult.Data.CheckUnitCode;
                    user.departName=httpRequestResult.Data.DepartName;
                    [[UserManager shareInstance] setUserInfo:user];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeDepartKVOKey object:nil];
                }
            }
           
            if (self.reloadReportList) {
                self.reloadReportList(httpRequestResult.Data.Reports);
            }
            
            if([reports count]==0){
                [CommonUtil showHUDWithTitle:@"未能找到体检报告！"];
            }else {
                [self.navigationController popViewControllerAnimated:YES];
            }

            
            
        }
        else{
            [CommonUtil showHUDWithTitle:httpRequestResult.Message];
        }
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.addReportBtn setRound];
    self.addReportBtn.enabled = NO;
    
    _user = [[UserManager shareInstance] getUserInfo];
    
    self.phoneNumTextField.text = _user.mobile;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.nameTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
