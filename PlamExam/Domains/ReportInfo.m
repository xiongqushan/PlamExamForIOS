//
//  ReportInfo.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportInfo.h"

@implementation CheckResult

@end

@implementation CheckItem
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"CheckResults":[CheckResult class]
             };
}
@end

@implementation GeneralSummary

@end

@implementation GeneralAdvice

@end

@implementation ReportInfo

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"CheckItems":[CheckItem class],
             @"GeneralSummarys":[GeneralSummary class],
             @"GeneralAdvices":[GeneralAdvice class]
             };
}

@end


