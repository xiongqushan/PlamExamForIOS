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
#import "ConsulationViewController.h"
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

#define kAdViewH 230*kScreenSizeWidth/375
#define kSectionItemW kScreenSizeWidth/2.0
#define kSectionItemH 132
#define kInformationViewH 40
#define kItemSpace 10
#define kSectionItemTag 101
#define kBackColor kSetRGBColor(242, 242, 242)

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, SZCirculationImageViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *adView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) NSMutableArray *adDataArr;

@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置badgeView
    UITabBarItem *tabBarItem = [[[self.tabBarController tabBar] items] objectAtIndex:1];
    tabBarItem.badgeCenterOffset = CGPointMake(0, 5);
    [tabBarItem showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
    
    [self loadAdScrollViewData];
    [self setUpTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadADListByNotification:) name:kChangeDepartKVOKey object:nil];
}

- (UIView *)tableHeaderView {
    
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kAdViewH)];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        [_tableHeaderView addSubview:self.adView];
    }
    return _tableHeaderView;
}

- (UIView *)adView {
    
    if (!_adView) {
        
        _adView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.tableHeaderView.bounds.size.width - 20, self.tableHeaderView.bounds.size.height - 20)];
        _adView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _adView;
}

- (void)setUpTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationCell" bundle:nil] forCellReuseIdentifier:@"InformationCell"];
}

- (void)loadAdScrollViewData {
    
    User* user=[[UserManager shareInstance] getUserInfo];
    self.adDataArr=[NSMutableArray array];
    [HomeModel requestADAndNotice:user.accountId withDepartId:user.departId requestADcallBack:^(HttpRequestResult<NSMutableArray<AdScrollerViewData *> *> *httpRequestResult) {
        if(httpRequestResult.IsSuccess){
            if (httpRequestResult.Data.count != 0) {
                [self.adDataArr addObjectsFromArray:httpRequestResult.Data];
                [self setUpHeadAdScrollViewIsInternet:YES];
            }
            else {
                [self setUpHeadAdScrollViewIsInternet:NO];
            }
        }
        else{
            [self setUpHeadAdScrollViewIsInternet:NO];
        }
    } requestNoticeCallback:^(HttpRequestResult<NSMutableArray<Notice *> *> *httpRequestResult) {
        
    } allFinishCallback:^(BOOL isAllSuccess) {
        
    }];
}

-(void) loadADListByNotification:(NSNotification*)notification{
    User* user=[[UserManager shareInstance] getUserInfo];
    self.adDataArr=[NSMutableArray array];
    [HomeModel requestADList:user.departId callBackBlock:^(HttpRequestResult<NSMutableArray<AdScrollerViewData *> *> *httpRequestResult) {
        if(httpRequestResult.IsSuccess){
            if (httpRequestResult.Data.count != 0) {
                [self.adDataArr addObjectsFromArray:httpRequestResult.Data];
                [self setUpHeadAdScrollViewIsInternet:YES];
            }
            else {
                [self setUpHeadAdScrollViewIsInternet:NO];
            }
        }
        else{
            [self setUpHeadAdScrollViewIsInternet:NO];
        }
    }];
}

- (void)setUpHeadAdScrollViewIsInternet:(BOOL)isInternet {
    
    if (isInternet) {
        //网络请求
        NSMutableArray *images = [NSMutableArray array];
        for (AdScrollerViewData *data in self.adDataArr) {
            [images addObject:data.ImageUrl];
        }

        SZCirculationImageView *imageView = [[SZCirculationImageView alloc] initWithFrame:self.adView.bounds andImageURLsArray:images];
        imageView.pauseTime = 3.0;
        imageView.currentPageColor = [UIColor whiteColor];
        imageView.delegate = self;
        [self.adView addSubview:imageView];
        
    }else {
        //本地请求
        NSArray *images = @[@"未加载图1"];
        SZCirculationImageView *imageView = [[SZCirculationImageView alloc] initWithFrame:self.adView.bounds andImageNamesArray:images];
        imageView.pauseTime = 3.0;
        imageView.currentPageColor = [UIColor whiteColor];
        imageView.delegate = self;
        [self.adView addSubview:imageView];
    }
}

#pragma mark -- SZCirculationImageViewDelegate
- (void)circulationImageView:(UIView *)circulationImageView didSelectIndex:(NSInteger)index {
    NSLog(@"_______%ld",index);
    AdScrollerViewData *data = self.adDataArr[index];
    
    InformationViewController *information = [[InformationViewController alloc] init];
    information.loadUrl = data.LinkUrl;
    [self.navigationController pushViewController:information animated:YES];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InformationCell"];

    cell.titleLabel.text = @"风口上的榜单";
    cell.contentLabel.text = @"盘点苹果精选的七大医疗领域89款明星APP";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    InformationViewController *information = [[InformationViewController alloc] init];
    
    [self.navigationController pushViewController:information animated:YES];
}

//创建分区头视图view
- (UIView *)setUpSectionHeaderView {
    CGFloat sectionViewH = kSectionItemH + kItemSpace*2 + kInformationViewH;
    
    NSArray *arr = @[@"体检报告",@"健康咨询"];
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, sectionViewH)];
    sectionHeaderView.backgroundColor = kBackColor;
    for (NSInteger i = 0; i < 2; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*kSectionItemW, kItemSpace, kSectionItemW, kSectionItemH)];
        view.backgroundColor = [UIColor whiteColor];
        view.tag = kSectionItemTag + i;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(view.bounds.size.width/2.0 - 24, 30, 48, 48)];
        imageView.image = [UIImage imageNamed:arr[i]];
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
    [informationBtn setImage:[UIImage imageNamed:@"资讯更多"] forState:UIControlStateNormal];
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

#pragma mark -- ClickEvent

- (void)itemTap:(UITapGestureRecognizer *)tap {
    UIView *tempView = tap.view;
    if (tempView.tag == kSectionItemTag) {
        //体检报告
        ReportListViewController *reportList = [[ReportListViewController alloc] init];
        [self.navigationController pushViewController:reportList animated:YES];
    }else if (tempView.tag == kSectionItemTag + 1) {
        //健康咨询
        ConsulationViewController *consulation = [[ConsulationViewController alloc] init];
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
