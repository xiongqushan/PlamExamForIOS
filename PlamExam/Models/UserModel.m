//
//  UserModel.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "UserModel.h"
#import "HttpHelper.h"
#import <YYModel.h>
#import "User.h"
#define kRegisterLogin @"User/Register"
#define kGetVerCode @"User/SMS"

@implementation UserModel

//获取验证码
+ (void)requestVerifyCode:(NSString*)mobile CallbackDelegate:(void(^)(HttpRequestResult<NSString*> *))callBack {
    NSDictionary *params=@{@"mobile":mobile};
    
    [HttpHelper Post:kGetVerCode withData:params withDelegate:^(HttpRequestResult *httpRequestResult) {
        
        HttpRequestResult<NSString *> *result = httpRequestResult;
        
        if(httpRequestResult.IsHttpSuccess){
           // result.Data =[[ZSIntType alloc] initWithValue:(int)httpRequestResult.HttpResult.Result];
           // result.Data = []
            result.Data = httpRequestResult.HttpResult.Result;
            callBack(result);
        }else {
            callBack(result);
        }
    }];
}

//登录
+ (void)requestLoginData:(NSString *)phoneNum verifyCode:(NSString *)verifyCode callback:(void (^)(HttpRequestResult<User *> *))callBack {
    NSDictionary *param = @{@"mobile":phoneNum,@"validCode":verifyCode,@"os":@"ios"};
    
    [HttpHelper Post:kRegisterLogin withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        
        HttpRequestResult<User *> *result = httpRequestResult;
        if (httpRequestResult.IsHttpSuccess) {
            result.Data = [User yy_modelWithJSON:httpRequestResult.HttpResult.Result];
            callBack(result);
        }else {
            callBack(result);
        }
    }];
}

@end
