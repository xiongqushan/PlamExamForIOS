//
//  ReportListViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportListViewController.h"
#import "ReportModel.h"
#import "User.h"
#import "UserManager.h"
#import "CommonUtil.h"
#import "ReportSimple.h"
#import "AddReportViewController.h"
#import "ReportViewController.h"
#import "ReportManager.h"

@interface ReportListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ReportListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"体检报告";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加报告" style:UIBarButtonItemStylePlain target:self action:@selector(addReport)];
    
    [self loadReportData];
    [self setUpTableView];

}


- (void)addReport {
    AddReportViewController *addReport = [[AddReportViewController alloc] init];
    addReport.reloadReportList = ^(NSArray<ReportSimple*>* reports){
        self.dataArr = [NSMutableArray arrayWithArray:reports];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:addReport animated:YES];
}

- (void)loadReportData {
    if([[ReportManager shareInstance] exist]){
        self.dataArr = [NSMutableArray arrayWithArray:[[ReportManager shareInstance] getReportList]];
        [self.tableView reloadData];
        return;
    }
    
    MBProgressHUD *hud = [CommonUtil createHUD];
    User *user = [[UserManager shareInstance] getUserInfo];
    [ReportModel requestReportList:user.accountId callBackBlock:^(HttpRequestResult<NSMutableArray<ReportSimple *> *> *httpRequestResult) {
        [hud hide:YES];

        if(httpRequestResult.IsSuccess){
            NSArray<ReportSimple*>*reports=httpRequestResult.Data;
            if(!reports){
                reports=[[NSArray<ReportSimple*> alloc] init];
            }
            [[ReportManager shareInstance] setReportList:reports];
            
            if (httpRequestResult.Data.count == 0) {
                //显示添加体检报告界面
                [self showAddReportView];
            }
            else {
                self.dataArr = [NSMutableArray arrayWithArray:httpRequestResult.Data];
                [self.tableView reloadData];
            }
        }
        else{

            [CommonUtil showHUDWithTitle:httpRequestResult.Message];
        }

    }];
}

- (void)showAddReportView {
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 32, 32);
    addBtn.center = view.center;
   // [addBtn setTitle:@"添加体检报告" forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"addReport"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addReport) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    titleLabel.center = CGPointMake(view.center.x, view.center.y+40);
    titleLabel.text = @"添加报告";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.textColor = kSetRGBColor(178, 178, 178);
    [view addSubview:titleLabel];
    
    [self.view addSubview:view];
}

- (void) setUpTableView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    ReportSimple *report = self.dataArr[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"姓名:%@  机构:%@",report.CustomerName,report.ReportName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"机构编号:%@ 体检号:%@ 日期:%@",report.CheckUnitCode,report.WorkNo,report.ReportDate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ReportSimple *report = self.dataArr[indexPath.row];
    ReportViewController *detail = [[ReportViewController alloc] init];
    detail.workNo = report.WorkNo;
    detail.checkUnitCode = report.CheckUnitCode;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
