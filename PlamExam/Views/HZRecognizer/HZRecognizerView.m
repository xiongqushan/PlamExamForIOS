//
//  HZRecognizerView.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZRecognizerView.h"
#import "HZRecognizer.h"
#import "GFWaterView.h"

@implementation HZRecognizerView
{
    NSTimer *_timer;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *recordImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        recordImage.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        recordImage.image = [UIImage imageNamed:@"edit_voiceinput"];
        [self addSubview:recordImage];
    }
    return self;
}

- (void)starRecognizerResult:(void(^)(NSString *result, NSString *desc))onResult {
    
    [[HZRecognizer shareManager] starRecognizerResult:^(NSString *result, NSString *errorDesc) {

        onResult(result, errorDesc);
        if (errorDesc) {
            return ;
        }
    }];
    
    //执行动画
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(starAnim) userInfo:nil repeats:YES];
    }
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)starAnim {
    __block GFWaterView *waterView = [[GFWaterView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    waterView.backgroundColor = [UIColor clearColor];
    [self insertSubview:waterView atIndex:0];
    
    [UIView animateWithDuration:2 animations:^{
        waterView.transform = CGAffineTransformScale(waterView.transform, 4, 4);
        waterView.alpha = 0;
    } completion:^(BOOL finished) {
        [waterView removeFromSuperview];
    }];
}

- (void)stopRecognizer {
    
    [_timer setFireDate:[NSDate distantFuture]]; //暂停定时器
    [[HZRecognizer shareManager] stopRecognizer]; //停止语音识别
    
//    if ([[HZRecognizer shareManager] isRecognizing]) {
//        [_timer setFireDate:[NSDate distantFuture]]; //暂停定时器
//        [[HZRecognizer shareManager] stopRecognizer]; //停止语音识别
//    }
}

//是否正在识别
- (BOOL)isRecognizing {
    
    return [[HZRecognizer shareManager] isRecognizing];
}

@end
