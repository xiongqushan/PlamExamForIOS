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

@interface InformationViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *wKWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) NSUInteger loadCount;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpWebView];
}

- (void)setUpWebView {
    
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
////    dispatch_async(dispatch_get_global_queue(0, 0), ^{
////        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://article.h5.ihaozhuo.com/1475216088834.html"]]];
////    });
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://article.h5.ihaozhuo.com/1475216088834.html"]]];
//
//    webView.UIDelegate = self;
//    webView.navigationDelegate = self;
//    webView.backgroundColor = [UIColor whiteColor];
//    webView.scrollView.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:webView];
//    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//    
//    self.wKWebView = webView;
    ZLCWebView *webView = [[ZLCWebView alloc] initWithFrame:self.view.bounds];

    [webView loadURLString:@"http://article.h5.ihaozhuo.com/1475216088834.html"];
    
    [self.view addSubview:webView];
    
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, 5)];
        _progressView.trackTintColor = [UIColor grayColor];
        _progressView.progressTintColor = [UIColor orangeColor];
        
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    
//    if ([keyPath isEqualToString:@"loading"]) {
//        
//    } else if ([keyPath isEqualToString:@"title"]) {
//        self.title = self.wKWebView.title;
//    } else if ([keyPath isEqualToString:@"URL"]) {
//        
//    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
//        
//        self.progressView.progress = self.wKWebView.estimatedProgress;
//    }
//    
//    if (object == self.wKWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
//        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
//        if (newprogress == 1) {
//            self.progressView.hidden = YES;
//            [self.progressView setProgress:0 animated:NO];
//        }else {
//            self.progressView.hidden = NO;
//            [self.progressView setProgress:newprogress animated:YES];
//        }
//    }
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        
        
        if (object ==_wKWebView) {
            
            [self.progressView setAlpha:1.0f];
            
            [self.progressView setProgress:self.wKWebView.estimatedProgress animated:YES];
            
            if(_wKWebView.estimatedProgress >=1.0f) {
                
                
                
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    [self.progressView setAlpha:0.0f];
                    
                } completion:^(BOOL finished) {
                    
                    [self.progressView setProgress:0.0f animated:NO];
                    
                }];
                
                
                
            }
            
        }
        
        else
            
        {
            
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
        
        
        
    }
    
}

//- (void)setLoadCount:(NSUInteger)loadCount {
//    _loadCount = loadCount;
//    
//    if (loadCount == 0) {
//        self.progressView.hidden = YES;
//        [self.progressView setProgress:0 animated:NO];
//    }else {
//        self.progressView.hidden = NO;
//        CGFloat oldP = self.progressView.progress;
//        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
//        if (newP > 0.95) {
//            newP = 0.95;
//        }
//        [self.progressView setProgress:newP animated:YES];
//        
//    }
//}
//
//// 页面开始加载时调用
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    self.loadCount ++;
//}
//
//// 内容返回时
//- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
//    self.loadCount --;
//}
////失败
//- (void)webView:(WKWebView *)webView didFailNavigation: (null_unspecified WKNavigation *)navigation withError:(NSError *)error {
//    self.loadCount --;
//    NSLog(@"%@",error);
//}

- (void)dealloc {
    [self.wKWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
