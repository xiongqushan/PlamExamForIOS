//
//  AddReportViewController.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BaseViewController.h"
#import "ReportSimple.h"
typedef void(^ReloadReportListBlock)(NSArray<ReportSimple*>*);

@interface AddReportViewController : BaseViewController

@property (nonatomic, copy) ReloadReportListBlock reloadReportList;

@end
