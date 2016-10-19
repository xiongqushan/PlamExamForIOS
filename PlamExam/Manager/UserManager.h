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

@property(nonatomic,strong)User* userInfo;

@property(nonatomic,assign)NSInteger doctorId;

+(UserManager*)shareInstance;

- (void)saveUserInfo:(User *)user;

- (User*)getUserInfo;

- (void)clearUserInfo;

- (BOOL)isLogin;

@end
