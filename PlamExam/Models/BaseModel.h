//
//  BaseModel.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/10.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestModel.h"

@interface BaseModel : NSObject

+ (void)requestTestData:(NSDictionary *)param resultBlock:(void(^)(TestModel *testArr, NSString *message))resultBlock;

@end
