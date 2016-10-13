//
//  BaseModel.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/10.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestModel.h"
#import "HttpRequestResult.h"
#import "HttpHelper.h"

@interface BaseModel : NSObject

//+ (void)requestTestData:(NSDictionary *)param resultBlock:(void(^)(TestModel *testArr, NSString *message))resultBlock;

+ (void)requestTestData1:(NSDictionary *)param resultBlock:(void (^)(HttpRequestResult<TestModel*> * httpResult))resultBlock;

@end
