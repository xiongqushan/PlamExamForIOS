//
//  HttpHelper.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/10.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HttpHelper.h"
#import "AFNetworkingProxy.h"
#import <YYModel/YYModel.h>
@implementation HttpHelper

+(void) Post:(NSString*)path withData:(NSDictionary*)params
     withDelegate:(void (^)(HttpRequestResult *httpRequestResult))callbackDelegate{
    [[AFNetworkingProxy shareInstance] POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HttpRequestResult *requestResult=[[HttpRequestResult alloc] init];
        requestResult.HttpStatus= [[responseObject objectForKey:@"code"] integerValue];
        NSDictionary *jsonDic = [responseObject objectForKey:@"data"];
        if (requestResult.HttpStatus >=200 && requestResult.HttpStatus<300){
            requestResult.IsHttpSuccess=true;
            requestResult.HttpResult=[ApiGlobalData yy_modelWithDictionary:jsonDic];
        }
        else if (requestResult.HttpStatus >=400 && requestResult.HttpStatus<500)
        {
            requestResult.HttpMessage = [responseObject objectForKey:@"msg"];
        }
        else if (requestResult.HttpStatus >=500 && requestResult.HttpStatus<600)
        {
            requestResult.HttpMessage = @"服务器出错了，请稍候再试";
        }
        else{
            requestResult.HttpMessage  = [NSString stringWithFormat:@"未知的错误%@",[responseObject objectForKey:@"msg"]];
        }
        callbackDelegate(requestResult);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HttpRequestResult *requestResult=[[HttpRequestResult alloc] init];
        requestResult.HttpStatus=0;
        requestResult.HttpMessage=@"服务器出错了，请稍候再试";
        callbackDelegate(requestResult);
    }];
    
}

@end
