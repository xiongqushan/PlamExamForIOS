//
//  HZRecognizer.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZRecognizer.h"

@implementation HZRecognizer
{
    BOOL _isCancle;
}

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static HZRecognizer *manager = nil;
    
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    });
    return manager;
}

- (void)starRecognizerResult:(void (^)(NSString *))onResult {
    self.onResult = onResult;
    if (_iFlySpeechRecognizer == nil) {
        
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写参数
        [_iFlySpeechRecognizer setParameter:nil forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    }
    
    _iFlySpeechRecognizer.delegate = self;
    
    //设置最长录音时间
    [_iFlySpeechRecognizer setParameter:@"60000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
    //设置后端点
    [_iFlySpeechRecognizer setParameter:@"3000" forKey:[IFlySpeechConstant VAD_EOS]];
    //设置前端点
    [_iFlySpeechRecognizer setParameter:@"3000" forKey:[IFlySpeechConstant VAD_BOS]];
    //设置采样率
    [_iFlySpeechRecognizer setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    //设置网络等待时间
    [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
    //设置是否有标点
    [_iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant ASR_PTT]];
    //设置语言
    [_iFlySpeechRecognizer setParameter:@"CHINESE" forKey:[IFlySpeechConstant LANGUAGE]];
    //设置方言
    [_iFlySpeechRecognizer setParameter:@"PUTONGHUA" forKey:[IFlySpeechConstant ACCENT]];
    
    //设置音频来源为麦克风
    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iFlySpeechRecognizer setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    _isCancle = NO;
    BOOL ret = [_iFlySpeechRecognizer startListening];
    if (!ret) {
        // NSLog(@"启动识别服务失败，请稍后重试");
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"启动识别服务失败，请稍后重试" delegate:nil cancelButtonTitle:@"好哒！" otherButtonTitles: nil] show];
    }
}

- (void)stopRecognizer {
    [_iFlySpeechRecognizer cancel];
    _isCancle = YES;
    
}

- (BOOL)isRecognizing {
    
    return [_iFlySpeechRecognizer isListening];
}

#pragma mark -- IFlySpeechRecognizerDelegate
- (void)onResults:(NSArray *)results isLast:(BOOL)isLast {
    //识别结果返回的代理
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    NSDictionary *dict = results[0];
    for (NSString *key in dict) {
        [resultStr appendFormat:@"%@",key];
    }
    if ([resultStr hasPrefix:@"。"]) {
        return;
    }
    self.onResult(resultStr);
}

- (void)onError:(IFlySpeechError *)errorCode {
    //识别会话结束返回的代理
    //self.onResult(@"");
    
    if (_isCancle) {
        self.onResult(@"");
        return;
    }
    
    [_iFlySpeechRecognizer startListening];
    _isCancle = NO;
    self.onResult(@"");
}

@end
