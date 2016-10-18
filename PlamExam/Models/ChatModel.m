

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
#define kSendMessageURL @"Consult/Send"
#define kReplyMessageURL @"Consult/Reply"

@implementation ChatModel

//获取聊天记录
+ (void)requestChatDataWithAccountId:(NSString *)accountId callBackBlock:(void (^)(HttpRequestResult<NSMutableArray *> *))callBack {
    NSDictionary *param = @{@"accountId":accountId};
    
    [HttpHelper Post:kGetChatDataURL withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<NSMutableArray *> *result = httpRequestResult;
        
        NSString * data = httpRequestResult.HttpResult.Result;
        NSMutableArray *dataArr = [NSMutableArray array];
        
        if (httpRequestResult.IsHttpSuccess) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            for (NSDictionary *dict in arr) {
                ChatData *chat = [ChatData yy_modelWithDictionary:dict];
                [dataArr addObject:chat];
            }
            httpRequestResult.Data = dataArr;
            callBack(result);
        }else {
            callBack(result);
        }
    }];
    
}

//发送消息
+ (void)sendMessageWithAccountId:(NSString *)accountId type:(NSInteger)type consultContent:(NSString *)content appendInfo:(NSString *)appendInfo consultDate:(NSString *)date callBackBlock:(void (^)(HttpRequestResult<NSString *> *))callBack {
    NSDictionary *param = @{@"accountId":accountId,@"type":@(type),@"consultContent":content,@"appendInfo":appendInfo,@"consultDate":date};
    [HttpHelper Post:kSendMessageURL withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        
        HttpRequestResult<NSString *> *result = httpRequestResult;
        NSString *data = httpRequestResult.HttpResult.Result;
        
        if (httpRequestResult.IsHttpSuccess) {
            result.Data = data;
            callBack(result);
        }else {
            callBack(result);
        }
    }];
}



@end
