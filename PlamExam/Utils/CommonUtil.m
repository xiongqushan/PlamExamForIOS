//
//  CommonUtil.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/12.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "CommonUtil.h"
#import "NSArray+Util.h"

@implementation CommonUtil

+ (NSString *)JSONStringWithSortDictionary:(NSDictionary *)dict
{
    
    NSArray *keys = [dict allKeys];
    NSArray *keySort=[keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableString *jsonStr = [[NSMutableString alloc]initWithString:@"{"];
    
    for (NSString *key in keySort) {
        id value = [dict objectForKey:key];
        if ([value isKindOfClass:[NSString class]] ) {
            [jsonStr appendFormat:@"\"%@\":\"%@\",",key,value];
        }else if([value isKindOfClass:[NSNumber class]] ){
            [jsonStr appendFormat:@"\"%@\":%@,",key,value];
        }else if([value isKindOfClass:[NSArray class]]){
            [jsonStr appendFormat:@"\"%@\":%@,",key,[value ToJsonString]];
        }else{
            [jsonStr appendFormat:@"\"%@\":%@,",key,[self JSONStringWithSortDictionary:value]];
        }
    }
    [jsonStr replaceCharactersInRange:NSMakeRange(jsonStr.length - 1, 1) withString:@"}"];
    return jsonStr;
}

+ (MBProgressHUD *)createHUD {
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.userInteractionEnabled = NO;
    HUD.removeFromSuperViewOnHide = YES;
    return HUD;
}

+ (void)showHUDWithTitle:(NSString *)title {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    HUD.userInteractionEnabled = NO;
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD show:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.detailsLabelText = title;
    [HUD hide:YES afterDelay:1];
    
    /*HUD.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD showAnimated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.label.text = title;
    [HUD hideAnimated:YES afterDelay:1];*/
}

//传入最大宽度 得到高度
+ (CGFloat)getHeightWithFont:(UIFont *)font title:(NSString *)title maxWidth:(CGFloat)width{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [title boundingRectWithSize:CGSizeMake(width, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.height;
}

+ (CGFloat)getWidthWithFont:(UIFont *)font text:(NSString *)text maxHeight:(CGFloat)height {
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(1000.0f, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.width;
}

//判断手机号
+ (BOOL)isPhoneNumber:(NSString *)phoneNumber {
    if (phoneNumber.length < 11) {
        // [HZUtils showHUDWithTitle:@"请输入正确的手机号"];
        return NO;
    }else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phoneNumber];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phoneNumber];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phoneNumber];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
            
        }else{
            // [HZUtils showHUDWithTitle:@"请输入正确的手机号"];
            return NO;
        }
    }
}

//判断字符串是否为空字符串
+ (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}
@end
