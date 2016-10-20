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

- (void)setUserInfo:(User *)user {
    instance.user=user;
    
    NSDictionary *dict = [instance.user yy_modelToJSONObject];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dict forKey:kUserInfoKey];
    [userDefaults synchronize];
}

- (void)clearUserInfo {
    instance.user=nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kUserInfoKey];
    [userDefaults synchronize];
}

-(User*)getUserInfo{
    if(instance.user){
        return instance.user;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * str = [userDefaults objectForKey:kUserInfoKey];
    [userDefaults synchronize];
    if (str) {
        instance.user=[User yy_modelWithJSON:str];
    }
    else{
        instance.user=nil;
    }
    return instance.user;
}

- (BOOL)isLogin {
    if(instance.user){
        return true;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * str = [userDefaults objectForKey:kUserInfoKey];
    [userDefaults synchronize];
    
    if (str) {
        instance.user=[User yy_modelWithJSON:str];
        return YES;
    }else {
        return NO;
    }
}

@end
