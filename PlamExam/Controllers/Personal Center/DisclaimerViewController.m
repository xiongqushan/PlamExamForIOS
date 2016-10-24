//
//  DisclaimerViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "DisclaimerViewController.h"
#import "ZLCWebView.h"

@interface DisclaimerViewController ()

@end

@implementation DisclaimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpWebView];
}

- (void)setUpWebView {
    
    ZLCWebView *webView = [[ZLCWebView alloc] initWithFrame:self.view.bounds];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"disclaimer" ofType:@"html"];
    NSString *content = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    
    [webView loadHTMLString:content];
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
