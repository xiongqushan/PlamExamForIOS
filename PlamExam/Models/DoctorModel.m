//
//  DoctorModel.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "DoctorModel.h"
#import "HttpHelper.h"

@implementation DoctorModel
+ (void)requestDoctorId:(NSString*)accountId CallbackDelegate:(void(^)(HttpRequestResult<ZSIntType*> * httpResult))callBack{
    NSDictionary *params=@{@"AccountId":accountId};
    [HttpHelper Post:@"User/DoctorId" withData:params withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<ZSIntType *> *result = httpRequestResult;
        if (httpRequestResult.IsHttpSuccess) {
            result.Data = [[ZSIntType alloc] initWithValue: [httpRequestResult.HttpResult.Result integerValue]];
        }
        callBack(result);
    }];
}

+(void)requestDoctorList:(void(^)(HttpRequestResult<NSArray<Doctor*>*> * httpResult))callBack{
    NSDictionary *params=@{};
    [HttpHelper Post:@"User/Doctors" withData:params withDelegate:^(HttpRequestResult *httpRequestResult) {
        HttpRequestResult<NSArray<Doctor*>*> *result = httpRequestResult;
        if (httpRequestResult.IsHttpSuccess) {
            NSArray<Doctor*> *arr = [NSJSONSerialization JSONObjectWithData:[httpRequestResult.HttpResult.Result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            result.Data=arr;
        }
        callBack(result);
    }];
}
@end
