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
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialUIManager.h"

#define kInformationDetail @"http://hz3bn04d2:7200/Examination.html#/exam/%ld/2"

@interface InformationViewController ()<ZLCWebViewDelegate>

@end

@implementation InformationViewController
{
    MBProgressHUD *_hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"资讯";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
   // [self loadData];
    [self setUpWebView];
}

- (void)share {
    //[self authWithPlatform:UMSocialPlatformType_Sina];
    
    __weak typeof(self) weakSelf = self;
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMShareMenuSelectionView *shareSelectionView, UMSocialPlatformType platformType) {
        
        [weakSelf shareTextToPlatformType:platformType];
    }];
}

- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
            NSDictionary *info = error.userInfo;
            [CommonUtil showHUDWithTitle:info[@"message"]];
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

-(void)authWithPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager]  authWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
       // [self.tableView reloadData];
        UMSocialAuthResponse *authresponse = result;
        NSString *message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,authresponse.uid,authresponse.accessToken];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)setUpWebView {
    
    ZLCWebView *webView = [[ZLCWebView alloc] initWithFrame:self.view.bounds];

    [webView loadURLString:[NSString stringWithFormat:kInformationDetail,_Id]];
    webView.delegate = self;
    //[webView loadURLString:self.loadUrl];
    
    [self.view addSubview:webView];
    
}

- (void)zlcwebViewDidStartLoad:(ZLCWebView *)webview {
    NSLog(@"页面开始加载");
    _hud = [CommonUtil createHUD];
}

- (void)zlcwebView:(ZLCWebView *)webview shouldStartLoadWithURL:(NSURL *)URL {
    NSLog(@"截取到URL:%@",URL);
}

- (void)zlcwebView:(ZLCWebView *)webview didFinishLoadingURL:(NSURL *)URL {
    NSLog(@"页面加载完成");
    _hud.hidden = YES;
}

- (void)zlcwebView:(ZLCWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error {
    NSLog(@"加载出现错误");
    _hud.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
