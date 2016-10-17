//
//  AFNetworkingProxy.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/10.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "AFNetworkingProxy.h"

@implementation AFNetworkingProxy
static AFNetworkingProxy *networkingProxy;

+(nonnull AFNetworkingProxy *)createInstance{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_8_0
        NSURL *baseURL = [NSURL URLWithString:[BaseURLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
#else
        NSURL *baseURL = [NSURL URLWithString:[BaseURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
#endif
        //会话配置
        NSURLSessionConfiguration *sessionConfigure = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //请求序列化
        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        requestSerializer.timeoutInterval = 15;
        requestSerializer.stringEncoding = NSUTF8StringEncoding;
        
        //响应序列化
        AFHTTPResponseSerializer *respondSerializer = [AFJSONResponseSerializer serializer];
        
        //初始化请求
        networkingProxy = [[self alloc]initWithBaseURL:baseURL sessionConfiguration:sessionConfigure];
        networkingProxy.requestSerializer = requestSerializer;
        networkingProxy.responseSerializer = respondSerializer;
        return networkingProxy;
}

@end
