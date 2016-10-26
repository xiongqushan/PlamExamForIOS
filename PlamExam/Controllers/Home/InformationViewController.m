//
//  InformationViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "InformationViewController.h"
#import <WebKit/WebKit.h>
#import "UIColor+Utils.h"
#import "ZLCWebView.h"
#import "NewsModel.h"
#import "NewsInfo.h"

#define kInformationDetail @"http://hzswvajgs01:100/Examination.html#/exam/%ld/2"

@interface InformationViewController ()<ZLCWebViewDelegate>

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"资讯";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
   // [self loadData];
    [self setUpWebView];
}

- (void)share {
    
}

- (void)setUpWebView {
    
    ZLCWebView *webView = [[ZLCWebView alloc] initWithFrame:self.view.bounds];

    [webView loadURLString:[NSString stringWithFormat:kInformationDetail,_Id]];
    webView.delegate = self;
    [webView loadURLString:self.loadUrl];
    
    [self.view addSubview:webView];
    
}

- (void)zlcwebViewDidStartLoad:(ZLCWebView *)webview {
    NSLog(@"页面开始加载");
}

- (void)zlcwebView:(ZLCWebView *)webview shouldStartLoadWithURL:(NSURL *)URL {
    NSLog(@"截取到URL:%@",URL);
}

- (void)zlcwebView:(ZLCWebView *)webview didFinishLoadingURL:(NSURL *)URL {
    NSLog(@"页面加载完成");
}

- (void)zlcwebView:(ZLCWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error {
    NSLog(@"加载出现错误");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
