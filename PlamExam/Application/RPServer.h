//
//  RPServer.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

/**
 *  单例服务类，控制整个应用的使用
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RPServer : NSObject

@property (nonatomic, strong, readonly) UITabBarController *rootTabbarViewController; //主根视图控制器

/**
    获取服务单例本身

 @return 单例本身
 */
+ (RPServer *)instance;

- (void)initAppServerConfigureWithOptions:(NSDictionary *)launchOptions;

- (void)showLoginAgain;

@end
