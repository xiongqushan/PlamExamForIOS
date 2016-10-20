//
//  User.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id":@"ID",
             @"accountId":@"AccountId",
             @"realName":@"RealName",
             @"mobile":@"Mobile",
             @"departId":@"DepartCode",
             @"departName":@"DepartName"};
}

@end
