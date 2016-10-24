//
//  FeedbackViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "FeedbackViewController.h"
#import "SystemSettingModel.h"
#import "UserManager.h"

@interface FeedbackViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpBaseUI];
}

- (void)setUpBaseUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"意见反馈";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendFeedback)];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 64 + 15, kScreenSizeWidth - 30, 164)];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:16];
    textView.textColor = kSetRGBColor(51, 51, 51);
    [textView setRound];
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 0.5;
    [self.view addSubview:textView];
    self.textView = textView;
    
    UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 64 +15 + 5, kScreenSizeWidth - 50, 21)];
    placeholderLabel.text = @"请留下您宝贵的建议，我们将不断完善";
    placeholderLabel.textColor = kSetRGBColor(153, 153, 153);
    placeholderLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;
    
}

- (void)sendFeedback {
    User *user = [[UserManager shareInstance] getUserInfo];
    
    MBProgressHUD *hud = [CommonUtil createHUD];
    [SystemSettingModel sendFeedbackDepartName:user.departName realName:user.realName mobile:user.mobile feedbackContent:self.textView.text callBack:^(HttpRequestResult<ZSBoolType *> *httpResult) {
        hud.hidden = YES;
        if (httpResult.IsSuccess) {
            NSLog(@"______反馈成功");
            [CommonUtil showHUDWithTitle:@"反馈成功"];
            self.textView.text = @"";
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [CommonUtil showHUDWithTitle:httpResult.Message];
        }
    }];
}

#pragma mark -- UITextViewDelegate 

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        self.placeholderLabel.text = @"请留下您宝贵的建议，我们将不断完善";
    }else {
        self.placeholderLabel.text = @"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
