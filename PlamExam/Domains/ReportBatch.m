//
//  ReportBatch.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportBatch.h"

@implementation ReportBatch
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Reports":[ReportSimple class]
             };
}
@end
