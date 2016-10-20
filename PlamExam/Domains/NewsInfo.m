//
//  NewsInfo.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "NewsInfo.h"

@implementation NewsInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id":@"id",
             @"title":@"title",
             @"time":@"time",
             @"descriptions":@"description",
             @"message":@"message"};
}
@end
