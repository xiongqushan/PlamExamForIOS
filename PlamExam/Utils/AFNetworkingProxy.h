//
//  AFNetworkingProxy.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/10.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@interface AFNetworkingProxy : AFHTTPSessionManager
+(nonnull AFNetworkingProxy*)shareInstance;
@end
