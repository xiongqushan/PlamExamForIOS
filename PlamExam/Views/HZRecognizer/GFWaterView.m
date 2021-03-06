//
//  GFWaterView.m
//  动画
//
//  Created by 李国峰 on 16/6/6.
//  Copyright © 2016年 李国峰. All rights reserved.
//

#import "GFWaterView.h"
#define kScreenSize [UIScreen mainScreen].bounds.size
#define BXInputH (kScreenSize.width > 375 ? 210 : 200)
#import "UIColor+Utils.h"

@implementation GFWaterView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    // 半径
    CGFloat rabius = 30;
    // 开始角
    CGFloat startAngle = 0;
    
    // 中心点
    CGPoint point = CGPointMake(kScreenSize.width /2.0, BXInputH/2.0);  // 中心店我手动写的,你看看怎么弄合适 自己在搞一下
    
    // 结束角
    CGFloat endAngle = 2*M_PI;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:rabius startAngle:startAngle endAngle:endAngle clockwise:YES];

    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = path.CGPath;       // 添加路径 下面三个同理
    
    layer.lineWidth = 0.3;
    layer.strokeColor = [UIColor navigationBarColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    
    [self.layer addSublayer:layer];

}

@end
