//
//  UserTextCell.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "UserTextCell.h"

@implementation UserTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.iconImageView setRoundWithRadius:25];
    [self.chatBgView setRound];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(ChatData *)chatData {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.contentLabel.text = chatData.Content;
    self.dateLabel.text = chatData.Date;
}

@end
