//
//  ReportItemCell.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportItemCell.h"

@implementation ReportItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(CheckResult *)result {
    self.titleLabel.text = result.CheckIndexCode;
    self.valueLabel.text = result.ResultValue;
    self.refLabel.text = result.TextRef;
    self.unitLabel.text = result.Unit;
}

@end
