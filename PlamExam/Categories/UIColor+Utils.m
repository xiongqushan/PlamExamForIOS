//
//  UIColor+Utils.m
//  Health
//
//  Created by 郭凯 on 16/5/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha {
    
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(int)hexValue {

    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)navigationBarColor {
    return [UIColor colorWithRed:40/255.0f green:134/255.0f blue:238/255.0f alpha:1.0];
}

+ (UIColor *)viewBackgroundColor {
    return kSetRGBColor(250, 250, 250);
}

+ (UIColor *)textColor {
    return kSetRGBColor(51, 51, 51);
}

+ (UIColor *)tabBarColor {
    return kSetRGBColor(39, 135, 239);
}

+ (UIColor *)dividerColor {
    return kSetRGBColor(221, 221, 221);
}

@end
