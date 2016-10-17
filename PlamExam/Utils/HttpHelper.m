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
    [postDic setValue:[NSString stringWithFormat:@"%ld",(NSInteger)[[NSDate date] timeIntervalSince1970]] forKey:@"timespan"];
    
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
    NSLog(@"______signStr:%@",signString);

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
        ApiGlobalData *apiGlobalData=[[ApiGlobalData alloc] init];
        apiGlobalData.Code=[[responseObject objectForKey:@"Code"] integerValue];
        apiGlobalData.Message=(NSString*)[responseObject objectForKey:@"Message"];
        id data=[responseObject objectForKey:@"Data"];
        NSString *dataString=nil;
        if([data isKindOfClass:[NSDictionary class]]){
            dataString= [(NSDictionary*)data yy_modelToJSONString];
        }
        else if([data isKindOfClass:[NSArray class]]){
            dataString= [(NSArray*)data yy_modelToJSONString];
        }
        else{
            dataString=data;
        }
        apiGlobalData.Result=dataString;
        requestResult.HttpResult=apiGlobalData;
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
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        NSString *errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        //http://hz3bn04d2:8070/api/V3/System/SMS
        
        NSString *errorMessage = error.userInfo[@"NSLocalizedDescription"];
        HttpRequestResult *requestResult=[[HttpRequestResult alloc] init];
        requestResult.HttpStatus=statusCode;
        requestResult.IsHttpSuccess = NO;
     //   requestResult.HttpMessage=@"服务器出错了，请稍候再试";
        requestResult.HttpMessage = errorMessage;
        callbackDelegate(requestResult);
    }];
    
}

@end
