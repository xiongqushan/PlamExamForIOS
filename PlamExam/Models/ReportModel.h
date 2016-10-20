//
//  ReportModel.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportSimple.h"
#import "ReportBatch.h"
@interface ReportModel : NSObject
+(void)requestReportList:(NSString*)accountId callBackBlock:(void (^)(HttpRequestResult<NSMutableArray<ReportSimple*> *> *httpRequestResult))callBack;

+(void)addReport:(NSString*)accountId withName:(NSString*)realName withMobile:(NSString*)mobile callBackBlock:(void (^)(HttpRequestResult<ReportBatch *> *httpRequestResult))callBack;
@end
