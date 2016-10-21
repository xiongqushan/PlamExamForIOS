//
//  InformationCell.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "InformationCell.h"
#import <UIImageView+WebCache.h>

@implementation InformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.iconImageView setRound];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(NewsSimple *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.imgFormat] placeholderImage:[UIImage imageNamed:@"AD_default"]];
    self.titleLabel.text = model.title;
    self.dateLabel.text = model.timeFormat;

}
@end
