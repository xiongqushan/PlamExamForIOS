//
//  HZRecognizer.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyMSC.h"

@interface HZRecognizer : NSObject <IFlySpeechRecognizerDelegate>
{
    IFlySpeechRecognizer *_iFlySpeechRecognizer;
}

@property (nonatomic, copy)void(^onResult)(NSString *result);

+ (instancetype)shareManager;

- (void)starRecognizerResult:(void(^)(NSString *result))onResult;

- (void)stopRecognizer;

- (BOOL)isRecognizing; //是否正在识别

@end
