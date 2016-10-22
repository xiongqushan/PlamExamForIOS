//
//  UserReportCell.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/22.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "UserReportCell.h"

@implementation UserReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.iconImageView setRoundWithRadius:23];
    [self.chatBgView setRound];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(ChatData *)chatData {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *arr = [chatData.AppendInfo componentsSeparatedByString:@";"];
    self.departmentNameLabel.text = arr[2];
    self.reportDateLabel.text = arr[3];
    self.sendMessageDateLabel.text = chatData.Date;
    self.contentLabel.text = chatData.Content;
}

@end
