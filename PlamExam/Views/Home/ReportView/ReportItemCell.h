//
//  ReportItemCell.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportInfo.h"

@interface ReportItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *refLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

- (void)showDataWithModel:(CheckResult *)result;

@end
