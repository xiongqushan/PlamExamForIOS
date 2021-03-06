//
//  HomeViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HomeViewController.h"
#import "UIColor+Utils.h"
#import "InformationCell.h"
#import "ConsultDetailViewController.h"
#import "InformationViewController.h"
#import "WZLBadgeImport.h"
#import "HomeModel.h"
#import "CommonUtil.h"
#import "AdScrollerViewData.h"
#import "SZCirculationImageView.h"
#import "ReportListViewController.h"
#import <MJRefresh.h>
#import "User.h"
#import "UserManager.h"
#import "Notice.h"
#import "NewsModel.h"
#import "NewsSimple.h"
#import "Notice.h"
#import "AdDetailViewController.h"
#import "NewsListViewController.h"
#import "NewsModel.h"
#import "AppDelegate.h"

#define kAdViewH 200
#define kAppointmentViewH 70

#define kSectionItemW kScreenSizeWidth/2.0
#define kSectionItemH 132
#define kInformationViewH 40
#define kItemSpace 10
#define kSectionItemTag 101
#define kBackColor kSetRGBColor(242, 242, 242)
#define kDefaultADName @"AD_default"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, SZCirculationImageViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *adView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIView *appointmentView;  //体检预约  挂号预约  风险评估所在的view
@property (nonatomic, strong) NSMutableArray<AdScrollerViewData*> *adDataArr;
@property (nonatomic, strong) NSMutableArray *newsDataArr;
@property (nonatomic, strong) UITabBarItem *tabBarItem;

@end

@implementation HomeViewController

- (UIView *)tableHeaderView {
    
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kAdViewH + kAppointmentViewH)];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        [_tableHeaderView addSubview:self.adView];
        [_tableHeaderView addSubview:self.appointmentView];
    }
    return _tableHeaderView;
}

- (UIView *)adView {
    
    if (!_adView) {
        _adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableHeaderView.bounds.size.width, kAdViewH)];
        _adView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _adView;
}

- (UIView *)appointmentView {
    if (!_appointmentView) {
        _appointmentView = [[UIView alloc] initWithFrame:CGRectMake(0, kAdViewH, kScreenSizeWidth, kAppointmentViewH)];
        _appointmentView.backgroundColor = [UIColor whiteColor];
        
       // CGFloat itemsSpace = (kScreenSizeWidth - 70*3 - 80)/2;
        NSArray *titleArr = @[@"体检预约",@"挂号预约",@"风险评估"];
        NSArray *imageNameArr = @[@"exam_appointment",@"register_appointment",@"risk_assessment"];
        CGFloat itemSpace = (kScreenSizeWidth - kAppointmentViewH*3)/4;
        for (NSInteger i = 0; i < 3; i++) {
           
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40 + (kAppointmentViewH+itemSpace)*i, 0, kAppointmentViewH, kAppointmentViewH)];
            view.backgroundColor = [UIColor whiteColor];
            [_appointmentView addSubview:view];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((kAppointmentViewH-30)/2.0, 10, 30, 29);
            [btn setImage:[UIImage imageNamed:imageNameArr[i]] forState:UIControlStateNormal];
            [view addSubview:btn];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kAppointmentViewH, 20)];
            titleLabel.text = titleArr[i];
            titleLabel.textColor = kSetRGBColor(102, 102, 102);
            titleLabel.font = [UIFont systemFontOfSize:15];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [view addSubview:titleLabel];
            
        }
        
    }
    
    return _appointmentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"掌上体检";
    self.adDataArr=[NSMutableArray array];
    self.newsDataArr = [NSMutableArray array];

    [self setUpTableView];
    
    [self showDefaultAd];
    [self loadAdScrollViewData];
    [self loadNewsData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadADListByNotification:) name:kChangeDepartKVOKey object:nil];
    //添加监听进入咨询详情清除小圆点的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearBadgeNotification:) name:kClearBadgeKVOKey object:nil];
    //监听添加小红点通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addBadgeNotification:) name:kAddBadgeKVOKey object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goConsult:) name:kGoConsulationNote object:nil];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (app.isNotification) {
        NSLog(@"_______YES!!!!!!");
    }else {
        NSLog(@"_______NO!!!!!!");
    }
}

//- (void)goConsult:(NSNotification *)note {
//    
//    [self.navigationController popToRootViewControllerAnimated:NO];
//    //健康咨询
//    ConsultDetailViewController *consulation = [[ConsultDetailViewController alloc] init];
//    
//    [self.navigationController pushViewController:consulation animated:YES];
//}


#pragma mark -- 设置UI相关
- (void)setUpTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64 - 49) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = self.tableHeaderView;
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewsData];
        [self loadAdScrollViewData];
    }];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
   // header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationCell" bundle:nil] forCellReuseIdentifier:@"InformationCell"];
}
#pragma mark -- 通知相关

- (void)clearBadgeNotification:(NSNotification *)notification {
    [self.tabBarItem clearBadge];
}

- (void)addBadgeNotification:(NSNotification *)notification {
    //设置badgeView
    self.tabBarItem = [[[self.tabBarController tabBar] items] objectAtIndex:1];
    self.tabBarItem.badgeCenterOffset = CGPointMake(0, 5);
    [self.tabBarItem showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
}


#pragma mark -- 网络请求相关
- (void)loadNewsData {
    User* user=[[UserManager shareInstance] getUserInfo];
    NSArray<NewsSimple*> *newList= [NewsModel getNewsListFromDB:user.Id];
    [self.newsDataArr addObjectsFromArray:newList];
    [self.tableView reloadData];
    [NewsModel requestList:1 PageSize:4 callBackBlock:^(HttpRequestResult<NSArray<NewsSimple *> *> *httpRequestResult) {
        if (httpRequestResult.IsSuccess && httpRequestResult.Data.count>0) {
            [self.newsDataArr removeAllObjects];
            [self.newsDataArr addObjectsFromArray:httpRequestResult.Data];
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            [NewsModel resaveNewsListFromDB:user.Id newsList:httpRequestResult.Data];
        }else {
            [CommonUtil showHUDWithTitle:httpRequestResult.Message];
        }
    }];
}

- (void)loadAdScrollViewData {
    
    User* user=[[UserManager shareInstance] getUserInfo];
    [HomeModel requestADAndNotice:user.accountId withDepartId:user.departId requestADcallBack:^(HttpRequestResult<NSMutableArray<AdScrollerViewData *> *> *httpRequestResult) {
        if(httpRequestResult.IsSuccess){
            if (httpRequestResult.Data.count > 0) {
                [self showNewAd:httpRequestResult.Data];
            }
        }
    } requestNoticeCallback:^(HttpRequestResult<NSMutableArray<Notice *> *> *httpRequestResult) {
        if(httpRequestResult.IsSuccess){
            for(Notice *notice in httpRequestResult.Data){
                if(notice.type==1){
                    //todo add red dot
                    //设置badgeView
                    self.tabBarItem = [[[self.tabBarController tabBar] items] objectAtIndex:1];
                    self.tabBarItem.badgeCenterOffset = CGPointMake(0, 5);
                    [self.tabBarItem showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
                    
                    break;
                }
            }
        }
    } allFinishCallback:^(BOOL isAllSuccess) {
        
    }];
}

-(void) loadADListByNotification:(NSNotification*)notification{
    User* user=[[UserManager shareInstance] getUserInfo];
    [HomeModel requestADList:user.departId callBackBlock:^(HttpRequestResult<NSMutableArray<AdScrollerViewData *> *> *httpRequestResult) {
        if(httpRequestResult.IsSuccess){
            if (httpRequestResult.Data.count > 0) {
                [self showNewAd:httpRequestResult.Data];
            }
            else {
                if(![self isCurrentShowDefaultAD]){
                    [self showDefaultAd];
                }
            }
        }
        else{
            if(![self isCurrentShowDefaultAD]){
                [self showDefaultAd];
            }
        }
    }];
}

-(void)showUpHeadAd{
    NSMutableArray *images = [NSMutableArray array];
    for (AdScrollerViewData *data in self.adDataArr) {
        [images addObject:data.ImageUrl];
    }
    SZCirculationImageView *imageView = [[SZCirculationImageView alloc] initWithFrame:self.adView.bounds andImageSourcePathArray:images];
    imageView.pauseTime = 3.0;
    imageView.currentPageColor = [UIColor whiteColor];
    imageView.delegate = self;
    NSArray *views=[self.adView subviews];
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    [self.adView addSubview:imageView];
}

-(void)showNewAd:(NSMutableArray<AdScrollerViewData*>*) adList{
    [self.adDataArr removeAllObjects];
    [self.adDataArr addObjectsFromArray:adList];
    [self showUpHeadAd];
}

-(void)showDefaultAd{
    if([self isCurrentShowDefaultAD]){
        return;
    }
    [self.adDataArr removeAllObjects];
    AdScrollerViewData * adItem=[[AdScrollerViewData alloc] init];
    adItem.ImageUrl=kDefaultADName;
    [self.adDataArr addObject:adItem];
    [self showUpHeadAd];
}

-(BOOL)isCurrentShowDefaultAD{
    if([self.adDataArr count]==1 && [self.adDataArr[0].ImageUrl isEqualToString:kDefaultADName]){
        return YES;
    }
    return NO;
}

#pragma mark -- SZCirculationImageViewDelegate
- (void)circulationImageView:(UIView *)circulationImageView didSelectIndex:(NSInteger)index {
    NSLog(@"_______%ld",index);
    AdScrollerViewData *data = self.adDataArr[index];
    if(data.LinkUrl!=nil && ![data.LinkUrl isEqualToString:@""]){
        AdDetailViewController *adDetail = [[AdDetailViewController alloc] init];
        adDetail.loadUrl = data.LinkUrl;
        [self.navigationController pushViewController:adDetail animated:YES];
    }
    
//    AdDetailViewController *adDetail = [[AdDetailViewController alloc] init];
//    adDetail.loadUrl = data.LinkUrl;
//    [self.navigationController pushViewController:adDetail animated:YES];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsSimple *news = self.newsDataArr[indexPath.row];
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InformationCell"];

    [cell showDataWithModel:news];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 89;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NewsSimple *news = self.newsDataArr[indexPath.row];
    InformationViewController *information = [[InformationViewController alloc] init];
    information.news = news;
    [self.navigationController pushViewController:information animated:YES];
}

//创建分区头视图view
- (UIView *)setUpSectionHeaderView {
    CGFloat sectionViewH = kSectionItemH + kItemSpace*2 + kInformationViewH;
    
    NSArray *arr = @[@"体检报告",@"健康咨询"];
    NSArray *imageArr = @[@"report",@"consulation"];
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, sectionViewH)];
    sectionHeaderView.backgroundColor = kBackColor;
    for (NSInteger i = 0; i < 2; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*kSectionItemW, kItemSpace, kSectionItemW, kSectionItemH)];
        view.backgroundColor = [UIColor whiteColor];
        view.tag = kSectionItemTag + i;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(view.bounds.size.width/2.0 - 24, 30, 48, 48)];
        imageView.image = [UIImage imageNamed:imageArr[i]];
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width/2.0 - 50, 30 + 48 +9, 100, 21)];
        label.textColor = kFontColor;
        label.text = arr[i];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
        [sectionHeaderView addSubview:view];
    }
    
    //添加体检报告  健康咨询之间的分割线
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.5, kSectionItemH - 20)];
    label.center = CGPointMake(sectionHeaderView.center.x, sectionHeaderView.center.y - 20);
    label.backgroundColor = [UIColor dividerColor];
    [sectionHeaderView addSubview:label];
    
    //添加资讯头视图界面
    UIView *informationView = [[UIView alloc] initWithFrame:CGRectMake(0, kSectionItemH + kItemSpace*2, sectionHeaderView.bounds.size.width, kInformationViewH)];
    informationView.backgroundColor = [UIColor whiteColor];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 3, kInformationViewH - 20)];
    leftLabel.backgroundColor = kSetRGBColor(242, 83, 83);
    [informationView addSubview:leftLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 5, 100, 30)];
    titleLabel.text = @"每日资讯";
    titleLabel.textColor = kSetRGBColor(51, 51, 51);
    [informationView addSubview:titleLabel];
    
    UIButton *informationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    informationBtn.frame = CGRectMake(informationView.bounds.size.width - 15 - 16, 10, 16, 20);
    [informationBtn addTarget:self action:@selector(goNewsList) forControlEvents:UIControlEventTouchUpInside];
    [informationBtn setImage:[UIImage imageNamed:@"newsMore"] forState:UIControlStateNormal];
    [informationView addSubview:informationBtn];
    
    [sectionHeaderView addSubview:informationView];
    return sectionHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    return [self setUpSectionHeaderView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return kSectionItemH + kItemSpace*2 + kInformationViewH;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

#pragma mark -- ClickEvent

//跳转资讯列表界面
- (void)goNewsList {
    NewsListViewController *newsList = [[NewsListViewController alloc] init];
    
    [self.navigationController pushViewController:newsList animated:YES];
}

//分区头视图上的View被点击
- (void)itemTap:(UITapGestureRecognizer *)tap {
    UIView *tempView = tap.view;
    if (tempView.tag == kSectionItemTag) {
        //体检报告
        ReportListViewController *reportList = [[ReportListViewController alloc] init];
        [self.navigationController pushViewController:reportList animated:YES];
    }else if (tempView.tag == kSectionItemTag + 1) {
        //健康咨询
        ConsultDetailViewController *consulation = [[ConsultDetailViewController alloc] init];
        
        [self.navigationController pushViewController:consulation animated:YES];
    }
}

#pragma mark -- 设置tableView分割线顶格
//-(void)viewDidLayoutSubviews
//{
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
//    
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
//        
//    }
//}
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
