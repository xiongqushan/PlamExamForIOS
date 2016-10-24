//
//  ReportListCell.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/21.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportSimple.h"

@interface ReportListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *reportDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *reportListCellBg;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

- (void)showDataWithModel:(ReportSimple *)report;

@end
