//
//  HomeViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HomeViewController.h"
#import "ADScrollView.h"
#import "UIColor+Utils.h"
#import "InformationCell.h"
#import "ConsulationViewController.h"

#define kAdViewH 180*kScreenSizeWidth/375
#define kSectionItemW (kScreenSizeWidth - kItemSpace*3)/2.0
#define kSectionItemH kSectionItemW
#define kInformationBtnH 40
#define kItemSpace 15
#define kSectionItemTag 101

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *adView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpHeadAdScrollView];
    [self setUpTableView];
}

- (void)setUpHeadAdScrollView {
    UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kAdViewH)];
    adView.backgroundColor = [UIColor grayColor];
   // self.tableView.tableHeaderView = adView;
    self.adView = adView;
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

//创建分区头视图view
- (UIView *)setUpSectionHeaderView {
    CGFloat sectionViewH = kSectionItemH + kItemSpace*2 + kInformationBtnH;
    
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, sectionViewH)];
    sectionHeaderView.backgroundColor = [UIColor colorWithHex:0xf5f5f5 alpha:1];
    for (NSInteger i = 0; i < 2; i++) {
        UIImageView *itemView = [[UIImageView alloc] initWithFrame:CGRectMake(kItemSpace+i*(kItemSpace+kSectionItemW), kItemSpace, kSectionItemW, kSectionItemH)];
        itemView.backgroundColor = [UIColor whiteColor];
        itemView.tag = kSectionItemTag + 1;
        itemView.userInteractionEnabled = YES;
        [itemView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
        [sectionHeaderView addSubview:itemView];
    }
    
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
//        ConsulationViewController *consulation = [[ConsulationViewController alloc] init];
//        [self.navigationController pushViewController:consulation animated:YES];
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
