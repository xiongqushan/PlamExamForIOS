//
//  ReportModel.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportModel.h"
#import "HttpHelper.h"
#import <YYModel.h>

#define kReportListUrl @"Report/Reports"
#define kAddReportUrl @"Report/Add"
#define kReportDetailUrl @"Report/ReportInfo"
@implementation ReportModel

+(void)requestReportList:(NSString*)accountId callBackBlock:(void (^)(HttpRequestResult<NSMutableArray<ReportSimple*> *> *httpRequestResult))callBack{
    NSDictionary *params=@{@"AccountId":accountId};
    
    [HttpHelper Post:kReportListUrl withData:params withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<NSMutableArray<ReportSimple*> *> *result = httpRequestResult;
        if(httpRequestResult.IsHttpSuccess){
            NSMutableArray<ReportSimple*> *dataArr = [NSMutableArray array];
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:[httpRequestResult.HttpResult.Result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            for (NSDictionary *dict in arr) {
                ReportSimple *item = [ReportSimple yy_modelWithDictionary:dict];
                [dataArr addObject:item];
            }
            result.Data = dataArr;
        }
        callBack(result);
        
    }];
}

+(void)addReport:(NSString*)accountId withName:(NSString*)realName withMobile:(NSString*)mobile callBackBlock:(void (^)(HttpRequestResult<ReportBatch *> *httpRequestResult))callBack{
    NSDictionary *params=@{@"AccountId":accountId,@"Mobile":mobile,@"RealName":realName};
    
    [HttpHelper Post:kAddReportUrl withData:params withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<ReportBatch *> *result = httpRequestResult;
        if(httpRequestResult.IsHttpSuccess){
            result.Data = [ReportBatch yy_modelWithJSON:result.HttpResult.Result];
        }
        callBack(result);
        
    }];
}

+(void)requestDetail:(NSString*)workNo withName:(NSString*)checkUnitCode withMobile:(NSString*)mobile callBackBlock:(void (^)(HttpRequestResult<ReportInfo *> *httpRequestResult))callBack{
    NSDictionary *params=@{@"WorkNo":workNo,@"CheckUnitCode":checkUnitCode};
    [HttpHelper Post:kReportDetailUrl withData:params withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<ReportInfo *> *result = httpRequestResult;
        if(httpRequestResult.IsHttpSuccess){
            result.Data = [ReportInfo yy_modelWithJSON:result.HttpResult.Result];
        }
        callBack(result);
        
    }];
}

@end
