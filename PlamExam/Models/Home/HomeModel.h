//
//  HomeModel.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestResult.h"
#import "AdScrollerViewData.h"
#import "Notice.h"
@interface HomeModel : NSObject

//获取广告滚动视图数据
+ (void)requestADAndNotice:(NSString*)accountId withDepartId:(NSString *)departId requestADcallBack:(void (^)(HttpRequestResult<NSMutableArray<AdScrollerViewData*> *> *httpRequestResult))requestADcallBack requestNoticeCallback:(void (^)(HttpRequestResult<NSMutableArray<Notice*> *> *httpRequestResult))requestNoticeCallback allFinishCallback:(void (^)(BOOL isAllSuccess))allFinishCallBack;

@end
