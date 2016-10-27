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
    
    if ([CommonUtil isBlankString:result.ValueRefFormat] && [CommonUtil isBlankString:result.Unit]) {
        self.valueLabel.hidden = YES;
        self.unitLabel.hidden = YES;
        self.titleLabel.text = result.CheckIndexName;
        self.refLabel.text = result.ResultValue;
    }else {
        self.valueLabel.hidden = NO;
        self.unitLabel.hidden = NO;
        self.titleLabel.text = result.CheckIndexName;
        self.valueLabel.text = result.ResultValue;
        
        if (![CommonUtil isBlankString:result.ValueRefFormat]) {
            self.refLabel.text = [NSString stringWithFormat:@"参考范围:%@",result.ValueRefFormat];
        }else {
            self.refLabel.text = @"";
        }
        
        if (![CommonUtil isBlankString:result.Unit]) {
            self.unitLabel.text = [NSString stringWithFormat:@"单位:%@",result.Unit];
        }else {
            self.unitLabel.text = @"";
        }
        
    }
    
}

@end
