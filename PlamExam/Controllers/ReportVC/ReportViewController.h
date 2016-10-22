//
//  ReportViewController.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BaseViewController.h"
#import "ReportSimple.h"

@interface ReportViewController : BaseViewController

@property (nonatomic, strong) ReportSimple *report;

@property (nonatomic, copy) NSString *beforVC;

@end
