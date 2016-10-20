//
//  HttpRequestResult.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HttpRequestResult.h"

@implementation HttpRequestResult

- (BOOL)IsSuccess {
    if(!self.IsHttpSuccess){
        return false;
    }
    return self.HttpResult.Code>0;
}

-(NSString *)Message{
    if(self.IsHttpSuccess && self.HttpResult.Code<0){
        return self.HttpResult.Message;
    }
    return self.HttpMessage;
}
@end


@implementation ApiGlobalData

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"Result":@"Data"};
}

@end
