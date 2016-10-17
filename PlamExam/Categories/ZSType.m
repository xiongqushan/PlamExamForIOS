//
//  ZSType.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ZSType.h"

@implementation ZSIntType
- (instancetype) initWithValue:(int)value{
    self = [super init];
    if (self)
    {
        self.Value=value;
    }
    return self;
}
@end
