//
//  PersonalViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "PersonalViewController.h"
#import "UserManager.h"
#import "BaseSetting.h"
#import "UIColor+Utils.h"
#import "HeaderView.h"
#import "UserInfoViewController.h"
#import "SystemSettingViewController.h"
#import "SampleRepportViewController.h"
#import "UserManager.h"
#import "User.h"

#define MaxIconWH  100.0  //用户头像最大的尺寸
#define MinIconWH  30.0  // 用户头像最小的头像
#define maxScrollOff 242
#define kHeaderViewH 242

@interface PersonalViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation PersonalViewController
{
    HeaderView *_headerView;
    UILabel *_nameLabel;
    UIImageView *_iconImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self setUpBaseUI];
    [self createItemData];

}

- (void)createItemData {
    ArrowItem *arrow = [ArrowItem itemWithTitle:@"个人资料" withImage:[UIImage imageNamed:@"personal"]];
    arrow.destVcClass = [UserInfoViewController class];

    ArrowItem *arrow2 = [ArrowItem itemWithTitle:@"系统设置" withImage:[UIImage imageNamed:@"setting"]];
    arrow2.destVcClass = [SystemSettingViewController class];
    
    ArrowItem *arrow3 = [ArrowItem itemWithTitle:@"报告示例" withImage:[UIImage imageNamed:@"report"]];
    arrow3.destVcClass = [SampleRepportViewController class];
    
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[arrow, arrow2, arrow3];
    [self.dataArr addObject:group];
    
}

- (void)setUpBaseUI {
    
    self.navigationItem.title = nil;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderViewH + 10, 0, 0, 0);
    HeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
    headerView.backgroundColor = [UIColor navigationBarColor];
    headerView.frame = CGRectMake(0, -kHeaderViewH - 10, kScreenSizeWidth, kHeaderViewH - 10);
    [headerView.iconBtn setRoundWithRadius:50];
    [headerView.iconBtn addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
    headerView.nameLabel.text = [[UserManager shareInstance] getUserInfo].realName;
    _headerView = headerView;
    [self.tableView insertSubview:headerView atIndex:0];
    
}

- (void)iconClick {
    //头像被点击
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat updateY = scrollView.contentOffset.y;
    _headerView.frame = CGRectMake(0, updateY, kScreenSizeWidth, - updateY);
    
    updateY += kHeaderViewH;
    CGFloat reduceW = updateY * (MaxIconWH - MinIconWH)/(kHeaderViewH - 64);
    CGFloat yuanW = MAX(MinIconWH, MaxIconWH - reduceW);
    
    _headerView.iconBtn.layer.cornerRadius = yuanW/2.0;
    
    _headerView.iconWidth.constant = yuanW;
    _headerView.iconHeight.constant = yuanW;
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark -- 界面将要显示在界面
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIView animateWithDuration:0.25 animations:^{
        [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1.0;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
