//
//  ChatModel.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestResult.h"
#import "ChatData.h"

@interface ChatModel : NSObject

//获取聊天记录
+ (void)requestChatDataWithAccountId:(NSString *)accountId callBackBlock:(void(^)(HttpRequestResult<NSMutableArray *> *httpResult))callBack;

//发送消息
+ (void)sendMessageWithAccountId:(NSString *)accountId type:(NSInteger)type consultContent:(NSString *)content appendInfo:(NSString *)appendInfo consultDate:(NSString *)date callBackBlock:(void(^)(HttpRequestResult<NSString *> *httpResult))callBack;

+ (void)Comment:(NSString *)accountId score:(NSString*)score content:(NSString *)content callBackBlock:(void (^)(HttpRequestResult<ZSBoolType *> *))callBack;
@end
