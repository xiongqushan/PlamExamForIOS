//
//  UserManager.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject

+ (void)saveUserInfo:(User *)user;

+ (void)clearUserInfo;

+ (BOOL)isLogin;

@end
