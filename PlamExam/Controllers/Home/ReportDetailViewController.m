//
//  ReportDetailViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportDetailViewController.h"
#import "ReportModel.h"

@interface ReportDetailViewController ()

@end

@implementation ReportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadReportDetailData];
}

- (void)loadReportDetailData {
    [ReportModel requestDetail:self.workNo withName:self.checkUnitCode withMobile:@"" callBackBlock:^(HttpRequestResult<ReportInfo *> *httpRequestResult) {
//        if (httpRequestResult) {
//            <#statements#>
//        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
