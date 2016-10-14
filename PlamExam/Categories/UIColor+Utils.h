//
//  UIColor+Utils.h
//  Health
//
//  Created by 郭凯 on 16/5/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

+ (UIColor *)colorWithHex:(int)hexValue;
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;

+ (UIColor *)navigationBarColor;

+ (UIColor *)viewBackgroundColor;

+ (UIColor *)textColor;

+ (UIColor *)tabBarColor;

@end
