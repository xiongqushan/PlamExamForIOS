//
//  HttpHelper.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/10.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestResult.h"

@interface HttpHelper : NSObject

+ (void) Post:(NSString*)path withData:(NSDictionary*)params
withDelegate:(void (^)(HttpRequestResult *httpRequestResult))callbackDelegate;

@end
