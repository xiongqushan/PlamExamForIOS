//
//  SettingItem.h
//  Health
//
//  Created by 郭凯 on 16/5/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SettingItem : NSObject

@property (nonatomic, strong)UIImage *titleImage;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subTitle;

@property (nonatomic, assign)Class destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title withImage:(UIImage *)image;
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle withImage:(UIImage *)image;

@end
