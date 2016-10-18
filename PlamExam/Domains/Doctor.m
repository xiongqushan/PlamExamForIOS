//
//  Doctor.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id":@"ID",
             @"realName":@"RealName",
             @"imageSrc":@"ImageSrc",
             @"speciality":@"Speciality"};
}

@end
