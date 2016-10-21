//
//  HomeModel.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HomeModel.h"
#import "HttpHelper.h"
#import <YYModel.h>
#import "BatchRequestParam.h"
#import "HttpBatchRequestHelper.h"

#define kBannersUrl @"Home/Banners"
#define kNoticeUrl @"Consult/Informs"

@implementation HomeModel

+(void)requestADList:(NSString*)departId callBackBlock:(void (^)(HttpRequestResult<NSMutableArray<AdScrollerViewData*> *> *httpRequestResult))callBack{
    NSDictionary *params=@{@"DepartCode":departId};
    [HttpHelper Post:kBannersUrl withData:params withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<NSMutableArray<AdScrollerViewData*> *> *result = httpRequestResult;
        if(httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0){
            NSMutableArray<AdScrollerViewData*> *dataArr = [NSMutableArray array];
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:[httpRequestResult.HttpResult.Result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            for (NSDictionary *dict in arr) {
                AdScrollerViewData *item = [AdScrollerViewData yy_modelWithDictionary:dict];
                [dataArr addObject:item];
            }
            result.Data=dataArr;
        }
        callBack(result);
    }];
}

+ (void)requestADAndNotice:(NSString*)accountId withDepartId:(NSString *)departId requestADcallBack:(void (^)(HttpRequestResult<NSMutableArray<AdScrollerViewData*> *> *httpRequestResult))requestADcallBack requestNoticeCallback:(void (^)(HttpRequestResult<NSMutableArray<Notice*> *> *httpRequestResult))requestNoticeCallback allFinishCallback:(void (^)(BOOL isAllSuccess))allFinishCallBack{
    
    NSDictionary *param = @{@"DepartCode":departId};
    
    [HttpHelper Post:kBannersUrl withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        
        HttpCallbackDelegate getADCallback=^(HttpRequestResult *httpRequestResult) {
            HttpRequestResult<NSMutableArray<AdScrollerViewData*> *> *result=httpRequestResult;
            if(result.IsHttpSuccess && httpRequestResult.HttpResult.Code>0){
                NSMutableArray<AdScrollerViewData*> *dataArr = [NSMutableArray array];
                NSArray *arr = [NSJSONSerialization JSONObjectWithData:[httpRequestResult.HttpResult.Result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
                for (NSDictionary *dict in arr) {
                    AdScrollerViewData *item = [AdScrollerViewData yy_modelWithDictionary:dict];
                    [dataArr addObject:item];
                }
                result.Data=dataArr;
            }
            if(requestADcallBack){
                requestADcallBack(result);
            }
        };
        
        HttpCallbackDelegate getNoticeCallback=^(HttpRequestResult *httpRequestResult) {
            HttpRequestResult<NSMutableArray<Notice*> *> *result=httpRequestResult;
            if(result.IsHttpSuccess && httpRequestResult.HttpResult.Code>0){
                NSMutableArray<Notice*> *dataArr = [NSMutableArray array];
                NSArray *arr = [NSJSONSerialization JSONObjectWithData:[httpRequestResult.HttpResult.Result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
                for (NSDictionary *dict in arr) {
                    Notice *item = [Notice yy_modelWithDictionary:dict];
                    [dataArr addObject:item];
                }
                result.Data=dataArr;
            }
            if(requestNoticeCallback){
                requestNoticeCallback(result);
            }
        };
        
        NSMutableArray *batchParam=[[NSMutableArray alloc] init];
        BatchRequestParam *adParam= [[BatchRequestParam alloc] initWithPath:kBannersUrl andParam:@{@"DepartId":departId} andCallback:getADCallback];
        BatchRequestParam *noticeParam=[[BatchRequestParam alloc] initWithPath:kNoticeUrl andParam:@{@"AccountId":accountId} andCallback:getNoticeCallback];
        [batchParam addObject:adParam];
        [batchParam addObject:noticeParam];
        [[[HttpBatchRequestHelper alloc] init] batchPost:batchParam withFinishRequest:allFinishCallBack];
    }];
    
}

@end
