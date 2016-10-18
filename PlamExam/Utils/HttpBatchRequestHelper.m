//
//  HttpBatchRequestHelper.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HttpBatchRequestHelper.h"
#import "HttpHelper.h"
@implementation HttpBatchRequestHelper
{
    NSMutableArray<NSString*> *loaddingRequests;
}

-(void)batchPost:(NSArray<BatchRequestParam*>*) requestParams withBeforeRequest:(void (^)())beforeRequest withFinishRequest:(void (^)(BOOL))finishRequest{
    beforeRequest();
    __block BOOL isAllSuccess=true;
    loaddingRequests=[[NSMutableArray<NSString*> alloc] init];
    for(BatchRequestParam *param in requestParams){
        [loaddingRequests addObject:param.identity];
        [HttpHelper Post:param.path withData:param.param withDelegate:^(HttpRequestResult *httpRequestResult) {
            param.callbackDelegate(httpRequestResult);
            if(!httpRequestResult.IsHttpSuccess){
                isAllSuccess=false;
            }
            [loaddingRequests removeObject:param.identity];
            if([loaddingRequests count]==0){
                finishRequest(isAllSuccess);
            }
        }];
    }
}
@end
