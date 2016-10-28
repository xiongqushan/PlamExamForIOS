//
//  AdDetailViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "AdDetailViewController.h"
#import "ZLCWebView.h"

@interface AdDetailViewController ()<ZLCWebViewDelegate>

@end

@implementation AdDetailViewController
{
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZLCWebView *webView = [[ZLCWebView alloc] initWithFrame:self.view.bounds];
    [webView loadURLString:self.loadUrl];
    webView.delegate = self;
    [self.view addSubview:webView];
}

- (void)zlcwebViewDidStartLoad:(ZLCWebView *)webview {
    NSLog(@"页面开始加载");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   
}

- (void)zlcwebView:(ZLCWebView *)webview shouldStartLoadWithURL:(NSURL *)URL {
    NSLog(@"截取到URL:%@",URL);
}

- (void)zlcwebView:(ZLCWebView *)webview didFinishLoadingURL:(NSURL *)URL {
    NSLog(@"页面加载完成");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
}

- (void)zlcwebView:(ZLCWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error {
    NSLog(@"加载出现错误");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
