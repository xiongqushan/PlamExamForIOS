//
//  NSArray+Util.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/12.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "NSArray+Util.h"

@implementation NSArray (Util)
- (NSString *)ToJsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
