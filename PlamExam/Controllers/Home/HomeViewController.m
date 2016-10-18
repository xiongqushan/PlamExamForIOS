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

#define kAdViewH 230*kScreenSizeWidth/375
#define kSectionItemW kScreenSizeWidth/2.0
#define kSectionItemH 132
#define kInformationBtnH 40
#define kItemSpace 10
#define kSectionItemTag 101
#define kBackColor kSetRGBColor(242, 242, 242)

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *adView;
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
    
    [self setUpHeadAdScrollView];
    [self setUpTableView];
    
}

- (void)loadAdScrollViewData {
    self.adDataArr = [NSMutableArray array];
    [HomeModel requestADScrollViewDataWithDepartId:@"123" callBack:^(HttpRequestResult<NSMutableArray *> *httpResult) {
        if (httpResult.IsHttpSuccess) {
            if (httpResult.HttpResult.Code == 1) {
                
                [self.adDataArr addObjectsFromArray:httpResult.Data];
                [self setUpHeadAdScrollView];
            }else {
                [CommonUtil showHUDWithTitle:httpResult.HttpResult.Message];
            }
        }else {
            [CommonUtil showHUDWithTitle:httpResult.HttpMessage];
        }
    }];
}

- (void)setUpHeadAdScrollView {
    
    if (!self.adView) {
        UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kAdViewH)];
        adView.backgroundColor = [UIColor whiteColor];
        self.adView = adView;
    }

    if (self.adDataArr.count == 0) {
        return;
    }
    
    NSMutableArray *images = [NSMutableArray array];
    for (AdScrollerViewData *data in self.adDataArr) {
        [images addObject:data.ImageUrl];
    }

    SZCirculationImageView *imageView = [[SZCirculationImageView alloc] initWithFrame:self.adView.bounds andImageURLsArray:images];
    imageView.pauseTime = 3.0;
    imageView.currentPageColor = [UIColor whiteColor];
    [self.adView addSubview:imageView];
    
}

- (void)setUpTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = self.adView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationCell" bundle:nil] forCellReuseIdentifier:@"InformationCell"];
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
    CGFloat sectionViewH = kSectionItemH + kItemSpace*2 + kInformationBtnH;
    
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.5, kSectionItemH - 20)];
    label.center = CGPointMake(sectionHeaderView.center.x, sectionHeaderView.center.y - 20);
    label.backgroundColor = [UIColor dividerColor];
    [sectionHeaderView addSubview:label];
    
    UIButton *informationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    informationBtn.userInteractionEnabled = NO;
    informationBtn.backgroundColor = [UIColor whiteColor];
    informationBtn.frame = CGRectMake(0, kSectionItemH + kItemSpace*2, sectionHeaderView.bounds.size.width, kInformationBtnH);
    [informationBtn setImage:[UIImage imageNamed:@"about"] forState:UIControlStateNormal];
    [informationBtn setTitle:@"资讯" forState:UIControlStateNormal];
    [informationBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    informationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [informationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [informationBtn setContentEdgeInsets:UIEdgeInsetsMake(0, kItemSpace, 0, 0)];
    //添加分割线
//    [informationBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [informationBtn.layer setBorderWidth:0.5];
//    [informationBtn.layer setMasksToBounds:YES];
    [sectionHeaderView addSubview:informationBtn];
    
    return sectionHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    return [self setUpSectionHeaderView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return kSectionItemH + kItemSpace*2 + kInformationBtnH;;
}

#pragma mark -- ClickEvent

- (void)itemTap:(UITapGestureRecognizer *)tap {
    UIView *tempView = tap.view;
    if (tempView.tag == kSectionItemTag) {
        //体检报告
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


@end
