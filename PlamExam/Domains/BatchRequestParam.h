//
//  BatchRequestParam.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallbackDelegate)(HttpRequestResult *httpRequestResult);

@interface BatchRequestParam : NSObject
@property(nonatomic,strong)NSString* identity;
@property(nonatomic,strong)NSString* path;
@property(nonatomic,strong)NSDictionary* param;
@property(nonatomic,copy)CallbackDelegate callbackDelegate;
- (instancetype) initWithValue:(NSString*)path andParam:(NSDictionary*)param andCallback:(CallbackDelegate)callbackDelegate;
@end
