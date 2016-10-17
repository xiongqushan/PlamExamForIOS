

//
//  ChatModel.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ChatModel.h"
#import "HttpHelper.h"
#import <YYModel.h>

#define kGetChatDataURL @"Consult/Chats"

@implementation ChatModel

+ (void)requestChatDataWithAccountId:(NSString *)accountId callBackBlock:(void (^)(HttpRequestResult<ChatData *> *))callBack {
    NSDictionary *param = @{@"accountId":accountId};
    
    [HttpHelper Post:kGetChatDataURL withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<ChatData *> *result = httpRequestResult;
        if (httpRequestResult.IsHttpSuccess) {
            result.Data = [ChatData yy_modelWithJSON:httpRequestResult.HttpResult.Result];
            callBack(result);
        }else {
            callBack(result);
        }
    }];
    
}

@end
