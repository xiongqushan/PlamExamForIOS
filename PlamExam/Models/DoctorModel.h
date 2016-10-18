//
//  DoctorModel.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestResult.h"
#import "Doctor.h"
@interface DoctorModel : NSObject
+ (void)requestDoctorId:(NSString*)accountId CallbackDelegate:(void(^)(HttpRequestResult<ZSIntType*> * httpResult))callBack;

+(void)requestDoctorList:(void(^)(HttpRequestResult<NSArray<Doctor*>*> * httpResult))callBack;
@end
