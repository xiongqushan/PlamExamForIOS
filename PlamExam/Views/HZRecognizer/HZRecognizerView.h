//
//  HZRecognizerView.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZRecognizerView : UIView

- (void)starRecognizerResult:(void(^)(NSString *result))onResult;

- (void)stopRecognizer;

- (BOOL)isRecognizing; //是否正在识别

@end
