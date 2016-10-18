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

#define kBannersUrl @"Home/Banners"

@implementation HomeModel

+ (void)requestADScrollViewDataWithDepartId:(NSString *)departId callBack:(void (^)(HttpRequestResult<NSMutableArray *> *))callBack {
    NSDictionary *param = @{@"departId":departId};
    
    [HttpHelper Post:kBannersUrl withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<NSMutableArray *> *result = httpRequestResult;
        
        NSString * data = httpRequestResult.HttpResult.Result;
        NSMutableArray *dataArr = [NSMutableArray array];
        
        if (httpRequestResult.IsHttpSuccess) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            
            for (NSDictionary *dict in arr) {
                AdScrollerViewData *adData = [AdScrollerViewData yy_modelWithDictionary:dict];
                [dataArr addObject:adData];
            }
            result.Data = dataArr;
            callBack(result);
        }else {
            callBack(result);
        }
    }];
    
}

@end
