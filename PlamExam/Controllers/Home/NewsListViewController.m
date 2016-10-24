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

@interface NewsListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *newsDataArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"健康资讯";
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationCell" bundle:nil] forCellReuseIdentifier:@"InformationCell"];
    
    [self.view addSubview:self.tableView];
}

//- (void)loadNewsData {
//    [NewsModel requestList:1 PageSize:20 callBackBlock:^(HttpRequestResult<NSArray<NewsSimple *> *> *httpRequestResult) {
//        if (httpRequestResult.IsSuccess) {
//            httpRequestResult.Data;
//        }else {
//            
//        }
//    }];
//}

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 89;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
