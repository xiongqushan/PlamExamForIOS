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
#import "Doctor.h"
@interface ChatModel : NSObject

//获取聊天记录
+ (void)requestChatDataWithAccountId:(NSString *)accountId callBackBlock:(void (^)(HttpRequestResult<NSMutableArray<ChatData*> *> *httpRequestResult))callBack ;

//获取聊天记录和监管师id
+ (void)requestChatDataAndDoctorId:(NSString *)accountId chatDataCallback:(void (^)(HttpRequestResult<NSMutableArray<ChatData*> *> *httpRequestResult))requestChartDataCallBack doctorIdCallback:(void (^)(HttpRequestResult<ZSIntType *> *httpRequestResult))requestDoctorIdCallBack allFinishCallback:(void (^)(BOOL isAllSuccess))allFinishCallBack;

+ (void)requestChatDataAndDoctorIdAndDoctorList:(NSString *)accountId chatDataCallback:(void (^)(HttpRequestResult<NSMutableArray<ChatData*> *> *httpRequestResult))requestChartDataCallBack doctorIdCallback:(void (^)(HttpRequestResult<ZSIntType *> *httpRequestResult))requestDoctorIdCallBack doctorListCallback:(void (^)(HttpRequestResult<NSMutableArray<Doctor*> *> *httpRequestResult))requestDoctorListCallBack allFinishCallback:(void (^)(BOOL isAllSuccess))allFinishCallBack;

//发送消息
+ (void)sendMessageWithAccountId:(NSString *)accountId type:(NSInteger)type consultContent:(NSString *)content appendInfo:(NSString *)appendInfo callBackBlock:(void(^)(HttpRequestResult<NSString *> *httpResult))callBack;

+(void)SendForReport:(NSString*)accountId content:(NSString*)content  checkUnitCode:(NSString*)checkUnitCode  workNo:(NSString*)workNo  checkUnitName:(NSString*)checkUnitName  reportDate:(NSString*)reportDate callBackBlock:(void (^)(HttpRequestResult<NSMutableArray<ChatData*> *> *))callBack;

+ (void)Comment:(NSString *)accountId score:(NSString*)score content:(NSString *)content callBackBlock:(void (^)(HttpRequestResult<ZSBoolType *> *))callBack;
@end
