//
//  UserManager.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

+ (void)saveUserInfo;

+ (void)clearUserInfo;

+ (BOOL)isLogin;

@end
