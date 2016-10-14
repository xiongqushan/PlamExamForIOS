//
//  UIView+Utils.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

- (void)setRound;

- (void)setRoundWithRadius:(CGFloat)radius;

- (void)addCuttingLine;

- (void)setErrorViewWithTarget:(id)target action:(SEL)sel;

- (void)removeErrorView;

@end
