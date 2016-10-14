//
//  BaseModel.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/10.
//  Copyright © 2016年 guokai. All rights reserved.
//

#define kRequestUrl @"Values/PostBB"

#import "BaseModel.h"
#import <YYModel/YYModel.h>

@implementation BaseModel

//+ (void)requestTestData:(NSDictionary *)param resultBlock:(void (^)(TestModel *, NSString *))resultBlock {
//    
//    [HttpHelper Post:kRequestUrl withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
//        
//        if (httpRequestResult.HttpMessage) {
//            NSLog(@"________%@",httpRequestResult.HttpMessage);
//            resultBlock(nil, httpRequestResult.HttpMessage);
//        }else {
//            NSLog(@"_________success!!");
//            NSLog(@"____%@ ______%@",httpRequestResult.HttpResult.Result,httpRequestResult.HttpMessage);
//            
//            TestModel *model = [[TestModel alloc] init];
//            model.name = @"test";
//            model.title = @"testTitle";
//            model.content = @"testContent";
//            
//            resultBlock(model,nil);
//        }
//
//    }];
//}

+ (void)requestTestData1:(NSDictionary *)param resultBlock:(void (^)(HttpRequestResult<TestModel*> *))resultBlock {
    
    [HttpHelper Post:kRequestUrl withData:param withDelegate:^(HttpRequestResult *httpRequestResult) {
        
        HttpRequestResult<TestModel*>* result=httpRequestResult;
        if(httpRequestResult.IsHttpSuccess){
            result.Data=[TestModel yy_modelWithJSON:httpRequestResult.HttpResult.Result];
        }else {
            resultBlock(result);
        }
        
        
    }];
}


@end
