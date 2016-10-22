//
//  UserReportCell.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/22.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportInfo.h"
#import "ChatData.h"

@interface UserReportCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *chatBgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *sendMessageDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)showDataWithModel:(ChatData *)chatData;

@end
