//
//  NewsModel.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//
#import "NewsInfo.h"
#import "NewsSimple.h"
#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
+(void)requestDetail:(NSInteger)Id callBackBlock:(void (^)(HttpRequestResult<NewsInfo *> *httpRequestResult))callBack;

+(void)requestList:(NSInteger)pageIndex PageSize:(NSInteger)pageSize callBackBlock:(void (^)(HttpRequestResult<NSArray<NewsSimple*> *> *httpRequestResult))callBack;
@end
