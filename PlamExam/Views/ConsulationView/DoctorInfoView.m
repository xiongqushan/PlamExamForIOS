//
//  DoctorInfoView.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "DoctorInfoView.h"
#import <UIImageView+WebCache.h>

@implementation DoctorInfoView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.iconImageView setRoundWithRadius:30];
    self.frame = CGRectMake(0, 64, kScreenSizeWidth, 70);
}

- (void)showDataWithModel:(Doctor *)doctor {
    self.nameLabel.text = doctor.realName;
    self.descriptionLabel.text = doctor.speciality;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:doctor.imageSrc] placeholderImage:[UIImage imageNamed:@"default"]];
}
@end
