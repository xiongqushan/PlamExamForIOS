//
//  HttpRequestResult.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiGlobalData : NSObject
@property(assign,nonatomic) NSInteger Code;
@property(strong,nonatomic) NSString *Message;
@property(strong,nonatomic) NSDictionary *Result;
@end


@interface HttpRequestResult<__covariant T> : NSObject
@property (assign,nonatomic) NSInteger HttpStatus;
@property(assign,nonatomic) BOOL IsHttpSuccess;
@property(strong,nonatomic) NSString *HttpMessage;
@property(strong,nonatomic) ApiGlobalData *HttpResult;
@property(strong,nonatomic) T Data;

@end

