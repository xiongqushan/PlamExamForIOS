//
//  NewsModel.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "NewsModel.h"
#import "HttpHelper.h"
#import <YYModel.h>

#define kNewsDetailUrl @"Home/MsgInfo"
#define kNewsListUrl @"Home/Msgs"
@implementation NewsModel


+(void)requestDetail:(NSInteger)Id callBackBlock:(void (^)(HttpRequestResult<NewsInfo *> *httpRequestResult))callBack{
    NSDictionary *params=@{@"ID":@(Id)};
    [HttpHelper Post:kNewsDetailUrl withData:params withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<NewsInfo *> *result = httpRequestResult;
        if(httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0){
            result.Data = [NewsInfo yy_modelWithJSON:result.HttpResult.Result];
        }
        callBack(result);
        
    }];
}

+(void)requestList:(NSInteger)pageIndex PageSize:(NSInteger)pageSize callBackBlock:(void (^)(HttpRequestResult<NSArray<NewsSimple*> *> *httpRequestResult))callBack{
    NSDictionary *params=@{@"PageIndex":@(pageIndex),@"PageSize":@(pageSize)};
    [HttpHelper Post:kNewsListUrl withData:params withDelegate:^(HttpRequestResult *httpRequestResult) {
        
        HttpRequestResult<NSArray<NewsSimple*> *> *result = httpRequestResult;
        if(httpRequestResult.IsHttpSuccess && httpRequestResult.HttpResult.Code>0){
            NSMutableArray<NewsSimple*> *dataArr = [NSMutableArray array];
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:[httpRequestResult.HttpResult.Result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            for (NSDictionary *dict in arr) {
                NewsSimple *item = [NewsSimple yy_modelWithDictionary:dict];
                [dataArr addObject:item];
            }
            result.Data = dataArr;
        }
        callBack(result);
        
    }];
}

@end
