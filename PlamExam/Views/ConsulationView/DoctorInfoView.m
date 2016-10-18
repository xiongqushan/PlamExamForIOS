//
//  DoctorInfoView.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "DoctorInfoView.h"

@implementation DoctorInfoView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.iconImageView setRoundWithRadius:30];
    self.frame = CGRectMake(0, 64, kScreenSizeWidth, 70);
}

@end
