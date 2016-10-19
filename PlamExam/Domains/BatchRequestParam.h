//
//  BatchRequestParam.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BatchRequestParam : NSObject
@property(nonatomic,strong)NSString* identity;
@property(nonatomic,strong)NSString* path;
@property(nonatomic,strong)NSDictionary* param;
@property(nonatomic,copy)HttpCallbackDelegate callbackDelegate;
- (instancetype) initWithPath:(NSString*)path andParam:(NSDictionary*)param andCallback:(HttpCallbackDelegate)callbackDelegate;
@end
