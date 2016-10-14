//
//  SettingItem.m
//  Health
//
//  Created by 郭凯 on 16/5/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle withImage:(UIImage *)image {
    SettingItem *item = [[self alloc] init];
    item.title = title;
    item.subTitle = subTitle;
    item.titleImage = image;
    return item;
    
}

+ (instancetype)itemWithTitle:(NSString *)title withImage:(UIImage *)image {
    return [self itemWithTitle:title subTitle:nil withImage:image];
}

+ (instancetype)itemWithTitle:(NSString *)title {
    return [self itemWithTitle:title subTitle:nil withImage:nil];
}
@end
