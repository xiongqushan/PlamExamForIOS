//
//  NewsListViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsModel.h"
#import "InformationCell.h"
#import "NewsSimple.h"
#import <MJRefresh.h>
#import "InformationViewController.h"

@interface NewsListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *newsDataArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NewsListViewController
{
    NSInteger _page;
    NSInteger _count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"健康资讯";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.newsDataArr = [NSMutableArray array];
    [self setUpTableView];
}

- (void)setUpTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationCell" bundle:nil] forCellReuseIdentifier:@"InformationCell"];
    [self.view addSubview:self.tableView];
    
    //创建下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self loadNewsDataPage:_page count:20];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    //创建上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [self loadNewsDataPage:_page count:20];
    }];
}

- (void)loadNewsDataPage:(NSInteger)page count:(NSInteger)count {
    
    [NewsModel requestList:page PageSize:count callBackBlock:^(HttpRequestResult<NSArray<NewsSimple *> *> *httpRequestResult) {
        
        if (_page == 1) {
            [self.newsDataArr removeAllObjects];
        }
        
        if (httpRequestResult.IsSuccess) {
            [self.newsDataArr addObjectsFromArray:httpRequestResult.Data];
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }else {
            [CommonUtil showHUDWithTitle:httpRequestResult.Message];
        }
    }];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSorce 
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InformationCell"];
    NewsSimple *news = self.newsDataArr[indexPath.row];
    [cell showDataWithModel:news];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsSimple *new = self.newsDataArr[indexPath.row];
    
    InformationViewController *info = [[InformationViewController alloc] init];
    
    info.news = new;
    [self.navigationController pushViewController:info animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 89;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
