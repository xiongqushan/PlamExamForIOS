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
#import "NSString+Util.h"
#import "CommonUtil.h"
@implementation HttpHelper


+(void) Post:(NSString*)path withData:(NSMutableDictionary*)params
     withDelegate:(void (^)(HttpRequestResult *httpRequestResult))callbackDelegate{
    
    NSMutableDictionary *postDic=[[NSMutableDictionary alloc] initWithDictionary:params];
    [postDic setValue:[NSString stringWithFormat:@"%ld",(NSInteger)[[NSDate date] timeIntervalSince1970]*1000] forKey:@"timespan"];
    
    AFNetworkingProxy *networkingProxy=[AFNetworkingProxy createInstance];
    NSMutableDictionary *signDic=[[NSMutableDictionary alloc] initWithDictionary:postDic];
    [signDic setValue:ApiSecret forKey:@"secret"];
    /*NSArray *keys=[signDic allKeys];
    NSArray *sortedKeys=[keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableDictionary *sortDic=[[NSMutableDictionary alloc] init];
    
    for(NSString *key in sortedKeys){
        [sortDic setValue:[signDic objectForKey:key] forKey:key];
        
    }
    
    NSString *signString = [sortDic yy_modelToJSONString];*/
    
    NSString *signString =[CommonUtil JSONStringWithSortDictionary:signDic];
    signString=[signString lowercaseString];
    signString=[signString md532BitLower];
    signString=[NSString stringWithFormat:@"%@:%@",HttpBasicKey,signString];
    signString=[signString base64EncodedString];
    signString = [NSString stringWithFormat:@"Basic %@",signString];
    //将认证信息添加到请求头
    [networkingProxy.requestSerializer setValue:signString forHTTPHeaderField:@"Authorization"];
    
    NSLog(@"_______path:%@",path);
    [networkingProxy POST:path parameters:postDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HttpRequestResult *requestResult=[[HttpRequestResult alloc] init];
        requestResult.HttpStatus=200;
        requestResult.IsHttpSuccess = YES;
        requestResult.HttpResult=[ApiGlobalData yy_modelWithJSON:responseObject];
        /*
        requestResult.HttpStatus= [[responseObject objectForKey:@"Code"] integerValue];
        NSDictionary *jsonDic = [responseObject objectForKey:@"Data"];
        if (requestResult.HttpStatus >=1 && requestResult.HttpStatus<300){
            requestResult.IsHttpSuccess=true;
            requestResult.HttpResult=[ApiGlobalData yy_modelWithDictionary:jsonDic];
        }
        else if (requestResult.HttpStatus >=400 && requestResult.HttpStatus<500)
        {
            requestResult.HttpMessage = [responseObject objectForKey:@"Message"];
        }
        else if (requestResult.HttpStatus >=500 && requestResult.HttpStatus<600)
        {
            requestResult.HttpMessage = @"服务器出错了，请稍候再试";
        }
        else{
            requestResult.HttpMessage  = [NSString stringWithFormat:@"未知的错误:%@",[responseObject objectForKey:@"Message"]];
        }*/
        callbackDelegate(requestResult);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        HttpRequestResult *requestResult=[[HttpRequestResult alloc] init];
        requestResult.HttpStatus=0;
        requestResult.IsHttpSuccess = NO;
        requestResult.HttpMessage=@"服务器出错了，请稍候再试";
        callbackDelegate(requestResult);
    }];
    
}

@end
