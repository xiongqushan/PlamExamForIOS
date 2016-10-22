//
//  UserTextCell.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatData.h"

@interface UserTextCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *chatBgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)showDataWithModel:(ChatData *)chatData;

@end
