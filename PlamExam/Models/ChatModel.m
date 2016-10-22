

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
#import "BatchRequestParam.h"
#import "HttpBatchRequestHelper.h"
#define kGetChatDataURL @"Consult/Chats"
#define kSendMessageURL @"Consult/Send"
#define kReplyMessageURL @"Consult/Reply"
#define kCommentURL @"Consult/Comment"
#define kDoctorIdUrl @"User/DoctorId"
#define kDoctorListUrl @"User/Doctors"
#define kSendForReportURL @"Consult/SendForReport"
@implementation ChatModel

//获取聊天记录
+ (void)requestChatDataWithAccountId:(NSString *)accountId callBackBlock:(void (^)(HttpRequestResult<NSMutableArray<ChatData*> *> *httpRequestResult))callBack {
    NSDictionary *param = @{@"accountId":accountId};
    
    [HttpHelper Post:kGetChatDataURL withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<NSMutableArray<ChatData*> *> *result = httpRequestResult;
        
        NSString * data = httpRequestResult.HttpResult.Result;
        NSMutableArray<ChatData*> *dataArr = [NSMutableArray array];
        
        if (httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            for (NSDictionary *dict in arr) {
                ChatData *chat = [ChatData yy_modelWithDictionary:dict];
                [dataArr addObject:chat];
            }

            result.Data = dataArr;

        }
        callBack(result);
    }];
}

+ (void)requestChatDataAndDoctorId:(NSString *)accountId chatDataCallback:(void (^)(HttpRequestResult<NSMutableArray<ChatData*> *> *httpRequestResult))requestChartDataCallBack doctorIdCallback:(void (^)(HttpRequestResult<ZSIntType *> *httpRequestResult))requestDoctorIdCallBack allFinishCallback:(void (^)(BOOL isAllSuccess))allFinishCallBack{
    
    HttpCallbackDelegate getChatDataCallback=^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<NSMutableArray<ChatData*> *> *result=httpRequestResult;
        if(result.IsHttpSuccess && httpRequestResult.HttpResult.Code>0){
            NSMutableArray<ChatData*> *dataArr = [NSMutableArray array];
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:[httpRequestResult.HttpResult.Result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            for (NSDictionary *dict in arr) {
                ChatData *chat = [ChatData yy_modelWithDictionary:dict];
                [dataArr addObject:chat];
            }
            result.Data=dataArr;
        }
        if(requestChartDataCallBack){
            requestChartDataCallBack(result);
        }
    };
    
    HttpCallbackDelegate getDoctorIdCallback=^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<ZSIntType *> *result=httpRequestResult;
        if(httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0){
            result.Data=[[ZSIntType alloc] initWithValue:[result.HttpResult.Result integerValue]];
        }
        if(requestDoctorIdCallBack){
            requestDoctorIdCallBack(result);
        }
    };
    
    NSDictionary *param = @{@"accountId":accountId};
    NSMutableArray *batchParam=[[NSMutableArray alloc] init];
    BatchRequestParam *chartdataParam= [[BatchRequestParam alloc] initWithPath:kGetChatDataURL andParam:param andCallback:getChatDataCallback];
    BatchRequestParam *doctorIdParam=[[BatchRequestParam alloc] initWithPath:kDoctorIdUrl andParam:param andCallback:getDoctorIdCallback];
    [batchParam addObject:chartdataParam];
    [batchParam addObject:doctorIdParam];
    [[[HttpBatchRequestHelper alloc] init] batchPostForSyncCallback:batchParam withFinishRequest:allFinishCallBack];
}

+ (void)requestChatDataAndDoctorIdAndDoctorList:(NSString *)accountId chatDataCallback:(void (^)(HttpRequestResult<NSMutableArray<ChatData*> *> *httpRequestResult))requestChartDataCallBack doctorIdCallback:(void (^)(HttpRequestResult<ZSIntType *> *httpRequestResult))requestDoctorIdCallBack doctorListCallback:(void (^)(HttpRequestResult<NSMutableArray<Doctor*> *> *httpRequestResult))requestDoctorListCallBack allFinishCallback:(void (^)(BOOL isAllSuccess))allFinishCallBack{
    
    HttpCallbackDelegate getChatDataCallback=^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<NSMutableArray<ChatData*> *> *result=httpRequestResult;
        if(httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0){
            NSMutableArray<ChatData*> *dataArr = [NSMutableArray array];
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:[httpRequestResult.HttpResult.Result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            for (NSDictionary *dict in arr) {
                ChatData *chat = [ChatData yy_modelWithDictionary:dict];
                [dataArr addObject:chat];
            }
            result.Data=dataArr;
        }
        if(requestChartDataCallBack){
            requestChartDataCallBack(result);
        }
    };
    
    HttpCallbackDelegate getDoctorIdCallback=^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<ZSIntType *> *result=httpRequestResult;
        if(httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0){
            result.Data=[[ZSIntType alloc] initWithValue:[result.HttpResult.Result integerValue]];
        }
        if(requestDoctorIdCallBack){
            requestDoctorIdCallBack(result);
        }
    };
    
    HttpCallbackDelegate getDoctorListCallback=^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<NSMutableArray<Doctor*> *> *result=httpRequestResult;
        if(httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0){
            NSMutableArray<Doctor*> *dataArr = [NSMutableArray array];
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:[httpRequestResult.HttpResult.Result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            for (NSDictionary *dict in arr) {
                Doctor *chat = [Doctor yy_modelWithDictionary:dict];
                [dataArr addObject:chat];
            }
            result.Data=dataArr;
        }
        if(requestDoctorListCallBack){
            requestDoctorListCallBack(result);
        }
    };
    
    NSDictionary *param = @{@"accountId":accountId};
    NSMutableArray *batchParam=[[NSMutableArray alloc] init];
    BatchRequestParam *chartdataParam= [[BatchRequestParam alloc] initWithPath:kGetChatDataURL andParam:param andCallback:getChatDataCallback];
    BatchRequestParam *doctorIdParam=[[BatchRequestParam alloc] initWithPath:kDoctorIdUrl andParam:param andCallback:getDoctorIdCallback];
    BatchRequestParam *doctorListParam=[[BatchRequestParam alloc] initWithPath:kDoctorListUrl andParam:@{} andCallback:getDoctorListCallback];
    [batchParam addObject:chartdataParam];
    [batchParam addObject:doctorIdParam];
    [batchParam addObject:doctorListParam];
    [[[HttpBatchRequestHelper alloc] init] batchPostForSyncCallback:batchParam withFinishRequest:allFinishCallBack];
}

/*
+(void)requestDoctorList:(void(^)(HttpRequestResult<NSArray<Doctor*>*> * httpResult))callBack{
    NSDictionary *params=@{};
    [HttpHelper Post:@"User/Doctors" withData:params withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<NSArray<Doctor*>*> *result = httpRequestResult;
        if (httpRequestResult.IsHttpSuccess) {
            NSArray<Doctor*> *arr = [NSJSONSerialization JSONObjectWithData:[httpRequestResult.HttpResult.Result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            result.Data=arr;
        }
        callBack(result);
    }];
}*/

//发送消息
+ (void)sendMessageWithAccountId:(NSString *)accountId type:(NSInteger)type consultContent:(NSString *)content appendInfo:(NSString *)appendInfo callBackBlock:(void (^)(HttpRequestResult<NSString *> *))callBack {
    NSDictionary *param = @{@"accountId":accountId,@"type":@(type),@"consultContent":content,@"appendInfo":appendInfo};
    [HttpHelper Post:kSendMessageURL withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        
        HttpRequestResult<NSString *> *result = httpRequestResult;
        if (httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0) {
            NSString *data = httpRequestResult.HttpResult.Result;
            result.Data = data;
        }
        callBack(result);
        
    }];
}

+(void)SendForReport:(NSString*)accountId content:(NSString*)content  checkUnitCode:(NSString*)checkUnitCode  workNo:(NSString*)workNo  checkUnitName:(NSString*)checkUnitName  reportDate:(NSString*)reportDate callBackBlock:(void (^)(HttpRequestResult<NSMutableArray<ChatData*> *> *))callBack{
    
    NSDictionary *param = @{@"AccountId":accountId,@"Type":@(kReportConsultType),@"ConsultContent":content,@"CheckUnitCode":checkUnitCode,@"WorkNo":workNo,@"CheckUnitName":checkUnitName,@"ReportDate":reportDate};
    [HttpHelper Post:kSendForReportURL withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        
        HttpRequestResult<NSMutableArray<ChatData*>*> *result = httpRequestResult;
        if (httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0) {
            NSMutableArray<ChatData*> *dataArr = [NSMutableArray array];
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:[httpRequestResult.HttpResult.Result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            for (NSDictionary *dict in arr) {
                ChatData *item = [ChatData yy_modelWithDictionary:dict];
                [dataArr addObject:item];
            }
            result.Data = dataArr;
        }
        callBack(result);
        
    }];
}

//评论
+ (void)Comment:(NSString *)accountId score:(NSString*)score content:(NSString *)content callBackBlock:(void (^)(HttpRequestResult<ZSBoolType *> *))callBack {
    NSDictionary *param = @{@"AccountId":accountId,@"Score":score,@"Content":content};
    [HttpHelper Post:kCommentURL withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<ZSBoolType *> *result = httpRequestResult;
        if (httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0) {
            result.Data = [[ZSBoolType alloc] initWithValue:[httpRequestResult.HttpResult.Result boolValue]];
        }
        callBack(result);
        
    }];
}

@end
