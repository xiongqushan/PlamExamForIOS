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
-(void)batchPost:(NSArray<BatchRequestParam*>*) requestParams withFinishRequest:(void (^)(BOOL isAllSuccess))finishRequest;

-(void)batchPostForSyncCallback:(NSArray<BatchRequestParam*>*) requestParams withFinishRequest:(void (^)(BOOL isAllSuccess))finishRequest;
@end
