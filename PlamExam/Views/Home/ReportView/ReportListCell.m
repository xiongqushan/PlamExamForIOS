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
    
    [self.reportListCellBg setRound];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(ReportSimple *)report {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    UIImage *image = [UIImage imageNamed:@"reportListCellBg"];
    self.reportListCellBg.image = [image stretchableImageWithLeftCapWidth:150 topCapHeight:60];
//    UIEdgeInsets insets = UIEdgeInsetsMake(40, 100, 40, 100);
//    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//    self.reportListCellBg.image = image;
    
    self.departmentNameLabel.text = report.ReportName;
    self.reportDateLabel.text = report.ReportDateFormat;
}

@end
