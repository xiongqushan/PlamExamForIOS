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
    NSMutableDictionary<NSString*,HttpRequestResult*> *backResults;
}

-(void)batchPost:(NSArray<BatchRequestParam*>*) requestParams withFinishRequest:(void (^)(BOOL isAllSuccess))finishRequest{
    __block BOOL isAllSuccess=true;
    loaddingRequests=[[NSMutableArray<NSString*> alloc] init];
    for(BatchRequestParam *param in requestParams){
        [loaddingRequests addObject:param.identity];
        [HttpHelper Post:param.path withData:param.param withDelegate:^(HttpRequestResult *httpRequestResult) {
            [loaddingRequests removeObject:param.identity];
            if(param){
                param.callbackDelegate(httpRequestResult);
            }
            if(!httpRequestResult.IsHttpSuccess){
                isAllSuccess=false;
            }
            if([loaddingRequests count]==0){
                if(finishRequest){
                    finishRequest(isAllSuccess);
                }
            }
        }];
    }
}

-(void)batchPostForSyncCallback:(NSArray<BatchRequestParam*>*) requestParams withFinishRequest:(void (^)(BOOL isAllSuccess))finishRequest{
    __block BOOL isAllSuccess=true;
    loaddingRequests=[[NSMutableArray<NSString*> alloc] init];
    backResults=[[NSMutableDictionary<NSString*,HttpRequestResult*> alloc] init];
    for(BatchRequestParam *param in requestParams){
        [loaddingRequests addObject:param.identity];
        [HttpHelper Post:param.path withData:param.param withDelegate:^(HttpRequestResult *httpRequestResult) {
            [loaddingRequests removeObject:param.identity];
            if(!httpRequestResult.IsHttpSuccess){
                isAllSuccess=false;
            }
            [backResults setValue:httpRequestResult forKey:param.identity];
            if([loaddingRequests count]==0){
                for(BatchRequestParam *p in requestParams){
                    if(p.callbackDelegate){
                        p.callbackDelegate(backResults[p.identity]);
                    }
                }
                if(finishRequest){
                    finishRequest(isAllSuccess);
                }
            }
        }];
    }
}
@end
