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
    
}

- (void)btnClick {
    
    _isRecogning = !_isRecogning;
    
    if (_isRecogning) {
        
        [_recognizer starRecognizerResult:^(NSString *result, NSString *errorDesc) {
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
