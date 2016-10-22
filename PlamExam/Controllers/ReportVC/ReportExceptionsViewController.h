//
//  ReportExceptionsViewController.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BaseViewController.h"
#import "ReportInfo.h"

@interface ReportExceptionsViewController : BaseViewController

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) ReportInfo *report;
@property (nonatomic, copy) NSString *beforVc;

@property (nonatomic, strong) UINavigationController *navigationController;
@end
