//
//  BaseModel.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/10.
//  Copyright © 2016年 guokai. All rights reserved.
//

#define kRequestUrl @"Values/Post3"

#import "BaseModel.h"
#import "RequestGlobalResult.h"
#import "HttpHelper.h"

@implementation BaseModel

+ (void)requestTestData:(NSDictionary *)param resultBlock:(void (^)(TestModel *, NSString *))resultBlock {
    
    [HttpHelper Post:kRequestUrl withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        
        if (httpRequestResult.HttpMessage) {
            NSLog(@"________%@",httpRequestResult.HttpMessage);
            resultBlock(nil, httpRequestResult.HttpMessage);
        }else {
            NSLog(@"_________success!!");
            TestModel *model = [[TestModel alloc] init];
            model.name = @"test";
            model.title = @"testTitle";
            model.content = @"testContent";
            
            resultBlock(model,nil);
        }

    }];
}

@end
