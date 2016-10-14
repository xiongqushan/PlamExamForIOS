//
//  UIView+Utils.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "UIView+Utils.h"
#import "UIColor+Utils.h"

@implementation UIView (Utils)

static UIGestureRecognizer *_tap;

- (void)setRound {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
}

- (void)setRoundWithRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)setBadgeValue:(NSInteger)badgeValue center:(CGPoint)point{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 30, 0, 22, 15)];
    label.center = point;
    //[label sizeToFit];
    label.text = [NSString stringWithFormat:@"%ld",badgeValue];
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 15/2.0;
    label.font = [UIFont systemFontOfSize:12];
    label.alpha = 0.8;
    // [label sizeToFit];
    if(label.bounds.size.width < 15) {
        CGRect frame = label.frame;
        frame.size.width = 15;
        label.frame = frame;
    }
    
    [self addSubview:label];
    [self bringSubviewToFront:label];
    if (badgeValue == 0) {
        label.hidden = YES;
    }
}

- (void)addCuttingLine {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cuttingLine"]];
    imageView.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 0.5);
    imageView.alpha = 0.8;
    [self addSubview:imageView];
}

- (void)setErrorViewWithTarget:(id)target action:(SEL)sel {

    UIView *errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    errorView.tag = 201;
    errorView.backgroundColor = [UIColor clearColor];
    errorView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    UIImageView *errorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error"]];
    errorImage.frame = CGRectMake(77, 10, 47, 47);
    [errorView addSubview:errorImage];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 160, 30)];
    titleLabel.text = @"点击屏幕重新加载";
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = [UIColor navigationBarColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [errorView addSubview:titleLabel];

    [self addSubview:errorView];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    [self addGestureRecognizer:_tap];
    
}

- (void)removeErrorView {
    for (UIView *view in self.subviews) {
        if (view.tag == 201) {
            [view removeFromSuperview];
        }
    }
    [self removeGestureRecognizer:_tap];
}

@end
