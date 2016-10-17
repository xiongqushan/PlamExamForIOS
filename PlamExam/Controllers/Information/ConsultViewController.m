//
//  ConsultViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ConsultViewController.h"
#import "GFWaterView.h"
#import "HZRecognizer.h"
#import "HZRecognizerView.h"

#define BXInputH (kScreenSizeWidth > 375 ? 210 : 200)
@interface ConsultViewController ()

@end

@implementation ConsultViewController
{
    UITextView *_textView;
    HZRecognizerView *_recognizer;
    BOOL _isRecogning;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 80, 50);
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(30, 450, kScreenSizeWidth - 60, 100)];
    [self.view addSubview:textView];
    _textView = textView;
    
    _recognizer = [[HZRecognizerView alloc] initWithFrame:CGRectMake(0, 200, kScreenSizeWidth, BXInputH)];
    _recognizer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_recognizer];
    
}

- (void)btnClick {
    
    _isRecogning = !_isRecogning;
    
    if (_isRecogning) {
        
        [_recognizer starRecognizerResult:^(NSString *result) {
            _textView.text = result;
        }];
    }else {
        [_recognizer stopRecognizer];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
