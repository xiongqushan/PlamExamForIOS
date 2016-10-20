//
//  NewsSimple.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "NewsSimple.h"

@implementation NewsSimple
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id":@"id",
             @"title":@"title",
             @"time":@"time",
             @"descriptions":@"description",
             @"img":@"img"};
}
@end
