//
//  SystemSettingModel.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SystemSettingModel.h"
#import "HttpHelper.h"

#define kSendFeedbackURL @"Home/AddFeedback"

@implementation SystemSettingModel

+ (void)sendFeedbackDepartName:(NSString *)departName realName:(NSString *)realName mobile:(NSString *)mobile feedbackContent:(NSString *)content callBack:(void (^)(HttpRequestResult<ZSBoolType *> *))callBack {
    NSDictionary *param = @{@"departName":departName,@"realName":realName,@"mobile":mobile,@"feedbackContent":content};
    
    [HttpHelper Post:kSendFeedbackURL withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        
        HttpRequestResult<ZSBoolType *> *result = httpRequestResult;
        
        if(httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0){
            ZSBoolType *boolType = [[ZSBoolType alloc] initWithValue:[httpRequestResult.HttpResult.Result boolValue]];
            result.Data = boolType;
        }
        
        callBack(result);
    }];
}
@end
