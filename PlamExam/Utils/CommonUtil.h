//
//  CommonUtil.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/12.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "HttpRequestResult.h"

@interface CommonUtil : NSObject

/**
 将字典转成按顺序排列（aa--zz）的字符串

 @param dict 传入一个字典

 @return 返回一个排过序的字符串
 */
+ (NSString *)JSONStringWithSortDictionary:(NSDictionary *)dict;

//判断是不是手机号
+ (BOOL)isPhoneNumber:(NSString *)phoneNumber;

//根据内容获取宽度
+ (CGFloat)getWidthWithFont:(UIFont *)font text:(NSString *)text maxHeight:(CGFloat)height;

//根据内容获取高度
+ (CGFloat)getHeightWithFont:(UIFont *)font title:(NSString *)title maxWidth:(CGFloat)width;

//创建提示框并显示在View上
+ (MBProgressHUD *)createHUD;

//显示一个只带有标题的提示框，并1秒之后自动消失
+ (void)showHUDWithTitle:(NSString *)title;

//判断字符串是否为空字符串
+ (BOOL)isBlankString:(NSString *)string;

+(NSString *)getGuid;

//判断网络请求是否成功
+ (NSString *)networkIsSuccess:(HttpRequestResult *)httpResult;

@end
