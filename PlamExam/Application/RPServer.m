//
//  RPServer.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "RPServer.h"

@implementation RPServer

/**
 单例的实现

 @return 静态的自己
 */
+ (RPServer *)instance {
    static RPServer *onlyServer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        onlyServer = [[RPServer alloc] init];
    });
    return onlyServer;
}

- (void)initAppServerConfigureWithOptions:(NSDictionary *)launchOptions {
    [self addSomeRootViewController];
}

- (void)showLoginAgain {
    
}

- (void)addSomeRootViewController {
    
}


@end
