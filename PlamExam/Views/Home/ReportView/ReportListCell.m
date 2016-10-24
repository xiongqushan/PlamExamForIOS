//
//  ReportListCell.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/21.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportListCell.h"

@implementation ReportListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.logoImageView setRoundWithRadius:36];
    [self.reportListCellBg setRound];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(ReportSimple *)report {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    UIImage *image = [UIImage imageNamed:@"reportListCellBg"];
    self.reportListCellBg.image = [image stretchableImageWithLeftCapWidth:150 topCapHeight:40];
    
    self.logoImageView.image = [UIImage imageNamed:@"departmentLogo"];
    self.departmentNameLabel.text = report.CustomerName;
    self.reportDateLabel.text = report.ReportDateFormat;
}

@end
