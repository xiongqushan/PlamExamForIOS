//
//  BatchRequestParam.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BatchRequestParam.h"
#import "CommonUtil.h"
@implementation BatchRequestParam
- (instancetype) initWithValue:(NSString*)path andParam:(NSDictionary*)param andCallback:(CallbackDelegate)callbackDelegate{
    self.identity=[CommonUtil getGuid];
    self.path=path;
    self.param=param;
    self.callbackDelegate=callbackDelegate;
    return self;
}
@end
