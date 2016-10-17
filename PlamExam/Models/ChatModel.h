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
+ (void)requestChatDataWithAccountId:(NSString *)accountId callBackBlock:(void(^)(HttpRequestResult<ChatData *> *httpResult))callBack;


@end
