//
//  ReportViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportModel.h"
#import "HZSliderView.h"
#import "ReportAnalyViewController.h"
#import "ReportDetailViewController.h"
#import "ReportExceptionsViewController.h"

@interface ReportViewController ()

@property (nonatomic, strong) NSMutableArray *reportDetailDataArr;
@property (nonatomic, strong) NSMutableArray *summaryDataArr;
@property (nonatomic, strong) NSMutableArray *unusualDataArr;

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reportDetailDataArr = [NSMutableArray array];
    self.summaryDataArr = [NSMutableArray array];
    self.unusualDataArr = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"体检报告";
    
    [self loadReportDetailData];
}

- (void)loadReportDetailData {
    
    [ReportModel requestDetail:self.workNo withName:self.checkUnitCode callBackBlock:^(HttpRequestResult<ReportInfo *> *httpRequestResult) {
        if (httpRequestResult.IsSuccess) {
            
            [self.reportDetailDataArr addObjectsFromArray:httpRequestResult.Data.CheckItems];
            [self setUpBaseUI];
        }else {
            [CommonUtil showHUDWithTitle:httpRequestResult.Message];
        }
    }];
}

- (void)setUpBaseUI {
    
    NSArray *titleArr = @[@"报告异常",@"报告详情",@"异常解读"];
    
    ReportExceptionsViewController *exceptions = [[ReportExceptionsViewController alloc] init];

    ReportDetailViewController *detail = [[ReportDetailViewController alloc] init];
    detail.dataArr = self.reportDetailDataArr;
    
    ReportAnalyViewController *analy = [[ReportAnalyViewController alloc] init];
    
    HZSliderView *slider = [[HZSliderView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64) titleArr:titleArr controllerNameArr:@[exceptions,detail,analy]];
    slider.titleFont = [UIFont systemFontOfSize:16];
    [self.view addSubview:slider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
