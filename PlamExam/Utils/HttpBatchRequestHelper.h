//
//  HttpBatchRequestHelper.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BatchRequestParam.h"
@interface HttpBatchRequestHelper : NSObject
-(void)batchPost:(NSArray<BatchRequestParam*>*) requestParams withBeforeRequest:(void (^)())beforeRequest withFinishRequest:(void (^)(BOOL))finishRequest;
@end
