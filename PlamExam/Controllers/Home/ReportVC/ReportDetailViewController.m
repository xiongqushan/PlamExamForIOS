//
//  ReportDetailViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportDetailViewController.h"
#import "ReportView.h"

@interface ReportDetailViewController ()

@end

@implementation ReportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ReportView *reportView = [[ReportView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight - 64 - 40)];
    reportView.dataArr = self.dataArr;
    [self.view addSubview:reportView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
