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

@interface HomeModel : NSObject

//获取广告滚动视图数据
+ (void)requestADScrollViewDataWithDepartId:(NSString *)departId callBack:(void(^)(HttpRequestResult<NSMutableArray *> *httpResult))callBack;

//获取资讯


@end
