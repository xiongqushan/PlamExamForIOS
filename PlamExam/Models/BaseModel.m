//
//  BaseModel.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/10.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BaseModel.h"
#import "RequestGlobalResult.h"
#import "HttpHelper.h"
@implementation BaseModel
-(void) GetDetail{
    //RequestGlobalResult<NSString*> *r=[[RequestGlobalResult alloc] init];
    
    
    [HttpHelper Post:<#(NSString *)#> withData:<#(NSDictionary *)#> withDelegate:^(HttpRequestResult *httpRequestResult) {
        
    }]
}
@end
