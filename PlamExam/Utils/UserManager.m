//
//  UserManager.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "UserManager.h"

#define kUserInfoKey @"UserInfoKey"

@implementation UserManager

+ (void)saveUserInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"1" forKey:kUserInfoKey];
    [userDefaults synchronize];
}

+ (void)clearUserInfo {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kUserInfoKey];
    [userDefaults synchronize];
}

+ (BOOL)isLogin {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * str = [userDefaults objectForKey:kUserInfoKey];
    [userDefaults synchronize];
    
    if (str) {
        return YES;
    }else {
        return NO;
    }
}

@end
