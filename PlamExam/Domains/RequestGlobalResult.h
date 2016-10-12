//
//  RequestGlobalResult.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/12.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestResult.h"
@interface RequestGlobalResult<__covariant T> : NSObject

@property (assign,nonatomic) NSInteger HttpStatus;
@property(assign,nonatomic) BOOL IsHttpSuccess;
@property(strong,nonatomic) NSString *HttpMessage;
@property(strong,nonatomic) T Data;

@end
