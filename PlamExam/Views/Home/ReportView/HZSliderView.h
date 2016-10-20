//
//  HZSliderView.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemScrollBlock)(NSInteger index);

@interface HZSliderView : UIView
//滑动时重置view 的位置
@property (nonatomic, copy)ItemScrollBlock scrollBlock;
@property (nonatomic, assign) CGFloat tabBarHeight; //滑动条的高度
@property (nonatomic, strong) UIFont *titleFont; //字体的大小
@property (nonatomic, strong) NSArray *imageArr; //如果有图片，存放图片默认没有
//@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, strong)UIView *tabBar;

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr controllerNameArr:(NSArray *)nameArr;

@end
