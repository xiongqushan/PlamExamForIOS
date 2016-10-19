//
//  UserManager.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "UserManager.h"
#import <YYModel.h>

#define kUserInfoKey @"UserInfoKey"

@implementation UserManager
static UserManager *instance = nil;

+(UserManager*)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)saveUserInfo:(User *)user {
    instance.userInfo=user;
    
    NSDictionary *dict = [instance.userInfo yy_modelToJSONObject];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dict forKey:kUserInfoKey];
    [userDefaults synchronize];
}

- (void)clearUserInfo {
    instance.userInfo=nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kUserInfoKey];
    [userDefaults synchronize];
}

-(User*)getUserInfo{
    if(instance.userInfo){
        return instance.userInfo;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * str = [userDefaults objectForKey:kUserInfoKey];
    [userDefaults synchronize];
    if (str) {
        instance.userInfo=[User yy_modelWithJSON:str];
    }
    else{
        instance.userInfo=nil;
    }
    return instance.userInfo;
}

- (BOOL)isLogin {
    if(instance.userInfo){
        return true;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * str = [userDefaults objectForKey:kUserInfoKey];
    [userDefaults synchronize];
    
    if (str) {
        instance.userInfo=[User yy_modelWithJSON:str];
        return YES;
    }else {
        return NO;
    }
}

@end
