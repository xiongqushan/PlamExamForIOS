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
#import "ReportListCell.h"

@interface ReportListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *addReportView;

@end

@implementation ReportListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报告列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加报告" style:UIBarButtonItemStylePlain target:self action:@selector(addReport)];
    
    [self loadReportData];
    [self setUpTableView];

}


- (void)addReport {
    AddReportViewController *addReport = [[AddReportViewController alloc] init];
    addReport.reloadReportList = ^(NSArray<ReportSimple*>* reports){
        
        self.addReportView.hidden = YES;
       // [self.addReportView removeFromSuperview];
        self.dataArr = [NSMutableArray arrayWithArray:reports];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:addReport animated:YES];
}

- (void)loadReportData {
    if([[ReportManager shareInstance] exist]){
        self.dataArr = [NSMutableArray arrayWithArray:[[ReportManager shareInstance] getReportList]];
        if (self.dataArr.count == 0) {
            self.addReportView.hidden = NO;
        }else {
            [self.tableView reloadData];
        }
        
        return;
    }
    
    MBProgressHUD *hud = [CommonUtil createHUD];
    User *user = [[UserManager shareInstance] getUserInfo];
    [ReportModel requestReportList:user.accountId callBackBlock:^(HttpRequestResult<NSMutableArray<ReportSimple *> *> *httpRequestResult) {
        hud.hidden = YES;

        if(httpRequestResult.IsSuccess){
            
            if (httpRequestResult.Data.count == 0) {
                //显示添加体检报告界面
                self.addReportView.hidden = NO;
            }
            else {
                NSArray<ReportSimple*>*reports=httpRequestResult.Data;
                if(!reports){
                    reports=[[NSArray<ReportSimple*> alloc] init];
                }
                [[ReportManager shareInstance] setReportList:reports];
                self.dataArr = [NSMutableArray arrayWithArray:httpRequestResult.Data];
                [self.tableView reloadData];
            }
        }
        else{

            [CommonUtil showHUDWithTitle:httpRequestResult.Message];
        }

    }];
}

- (UIView *)addReportView {
    if (!_addReportView) {
        _addReportView = [[UIView alloc] initWithFrame:self.view.bounds];
        _addReportView.backgroundColor = [UIColor whiteColor];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(0, 0, 32, 32);
        addBtn.center = _addReportView.center;
        // [addBtn setTitle:@"添加体检报告" forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageNamed:@"addReport"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addReport) forControlEvents:UIControlEventTouchUpInside];
        [_addReportView addSubview:addBtn];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
        titleLabel.center = CGPointMake(_addReportView.center.x, _addReportView.center.y+40);
        titleLabel.text = @"添加报告";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:19];
        titleLabel.textColor = kSetRGBColor(178, 178, 178);
        [_addReportView addSubview:titleLabel];
        
        [self.view addSubview:self.addReportView];
        
    }
    
    return _addReportView;
}

//- (void)showAddReportView {
//
//    [self.view addSubview:self.addReportView];
//}

- (void) setUpTableView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = kSetRGBColor(237, 238, 239);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
   // [self.tableView registerNib:[UINib nibWithNibName:@"ReportListId" bundle:nil] forCellReuseIdentifier:@"ReportListId"];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    ReportListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportListId"];
    ReportSimple *report = self.dataArr[indexPath.row];
//    [cell showDataWithModel:report];
//    return cell;
    
    static NSString *cellId = @"CellId";
    ReportListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ReportListCell" owner:self options:nil] lastObject];
    }
    
    [cell showDataWithModel:report];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ReportSimple *report = self.dataArr[indexPath.row];
    ReportViewController *detail = [[ReportViewController alloc] init];

    detail.report = report;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
