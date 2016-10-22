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
@property (nonatomic, strong) NSMutableArray *analyDataArr;
@property (nonatomic, strong) NSMutableArray *unusualDataArr;

@property (nonatomic, strong) ReportInfo *reportInfo;

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reportDetailDataArr = [NSMutableArray array];
    self.analyDataArr = [NSMutableArray array];
    self.unusualDataArr = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"体检报告";
    
    [self loadReportDetailData];
}

- (void)loadReportDetailData {
    
    [ReportModel requestDetail:self.report.WorkNo withName:self.report.CheckUnitCode callBackBlock:^(HttpRequestResult<ReportInfo *> *httpRequestResult) {
        if (httpRequestResult.IsSuccess) {
            [self.reportDetailDataArr addObjectsFromArray:httpRequestResult.Data.CheckItems];
            
            //获取异常项数据
            for (CheckItem *item in self.reportDetailDataArr) {
                for (CheckResult *result in item.CheckResults) {
                    if (result.IsAbnormalForamt) {
                        [self.unusualDataArr addObject:result];
                    }
                }
            }
            
            [self.analyDataArr addObjectsFromArray:httpRequestResult.Data.GeneralAdvices];
            
            self.reportInfo = httpRequestResult.Data;
            [self setUpBaseUI];
        }else {
            [CommonUtil showHUDWithTitle:httpRequestResult.Message];
        }
    }];
}

- (void)setUpBaseUI {
    
    NSArray *titleArr = @[@"报告异常",@"报告详情",@"异常解读"];
    
    ReportExceptionsViewController *exceptions = [[ReportExceptionsViewController alloc] init];
    exceptions.dataArr = self.unusualDataArr;
    exceptions.report = self.reportInfo;
    exceptions.navigationController = self.navigationController;

    ReportDetailViewController *detail = [[ReportDetailViewController alloc] init];
    detail.dataArr = self.reportDetailDataArr;
    
    ReportAnalyViewController *analy = [[ReportAnalyViewController alloc] init];
    analy.dataArr = self.analyDataArr;
    
    HZSliderView *slider = [[HZSliderView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64) titleArr:titleArr controllerNameArr:@[exceptions,detail,analy]];
    [self.view addSubview:slider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
