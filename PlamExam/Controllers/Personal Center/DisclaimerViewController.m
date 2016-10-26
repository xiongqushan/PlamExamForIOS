//
//  DisclaimerViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "DisclaimerViewController.h"
#import "ZLCWebView.h"
#import "UIColor+Utils.h"

@interface DisclaimerViewController ()

@property (nonatomic, strong) ZLCWebView *webView;

@end

@implementation DisclaimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpWebView];
}

- (void)setUpWebView {
    
    if ([self.navTitle isEqualToString:@"免责声明"]) {
        self.navigationItem.title = @"免责声明";
        self.webView = [[ZLCWebView alloc] initWithFrame:self.view.bounds];
    }else {
        [self createNavigationBarView];
        self.webView = [[ZLCWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, self.view.bounds.size.height - 64)];
    }
    
    self.webView.wkWebView.backgroundColor = kSetRGBColor(200, 200, 200);
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"disclaimer" ofType:@"html"];
    NSString *content = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:content];
    [self.view addSubview:self.webView];
    
}

- (void) createNavigationBarView {
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 64)];
    navigationBarView.backgroundColor = [UIColor navigationBarColor];
    
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenSizeWidth - 200)/2, 27, 200, 30)];
    navLabel.textColor = [UIColor whiteColor];
    navLabel.text = self.navTitle;
    navLabel.font = [UIFont boldSystemFontOfSize:18];
    navLabel.textAlignment = NSTextAlignmentCenter;
    [navigationBarView addSubview:navLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateHighlighted];
    [backBtn addTarget: self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(10, 23, 22, 38);
    [navigationBarView addSubview:backBtn];
    
    [self.view addSubview:navigationBarView];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
