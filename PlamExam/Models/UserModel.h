//
//  UserModel.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestResult.h"
#import "User.h"
#import "ZSType.h"

@interface UserModel : NSObject

//获取验证码
+ (void)requestVerifyCode:(NSString*)mobile CallbackDelegate:(void(^)(HttpRequestResult<NSString*> * httpResult))callBack;

//登录
+ (void)requestLoginData:(NSString *)phoneNum verifyCode:(NSString *)verifyCode callback:(void(^)(HttpRequestResult<User *>* httpResult))callBack;

@end
