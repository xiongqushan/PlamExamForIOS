//
//  ReportExceptionsViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportExceptionsViewController.h"
#import "ReportItemCell.h"
#import "ReportInfo.h"
#import "UIColor+Utils.h"
#import "ChatModel.h"
#import "CommonUtil.h"
#import "UserManager.h"
#import "ConsultDetailViewController.h"
#import "ReportListViewController.h"

#define kSelectedItemViewH (44 + 15)

@interface ReportExceptionsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *selectedItems;

@end

@implementation ReportExceptionsViewController
{
    BOOL _isAllSelected;
}

- (NSMutableArray *)selectedItems {
    if (!_selectedItems) {
        _selectedItems = [NSMutableArray array];
    }
    return _selectedItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0xF2F2F2];
    [self setUpTableView];
    [self setUpBottomView];
}

- (void)setUpTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, self.view.bounds.size.height - 64 - 55 - kSelectedItemViewH) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = [UIColor colorWithHex:0xF2F2F2];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerNib:[UINib nibWithNibName:@"ReportItemCell" bundle:nil] forCellReuseIdentifier:@"ReportItemCell"];
}

- (void)setUpBottomView {
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - kSelectedItemViewH - 64 - 55, kScreenSizeWidth, kSelectedItemViewH)];
    selectedView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:selectedView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(44, 0, selectedView.bounds.size.width - 88, 44);
    [btn setTitle:@"选择异常项咨询" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(selectedItem:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = kSetRGBColor(48, 155, 242);
    [btn setRound];
    
    [selectedView addSubview:btn];
}

- (void)selectedItem:(UIButton *)btn {
    
    if (!_isAllSelected) {
        _isAllSelected = YES;
        
        self.tableView.editing = YES;
        self.tableView.allowsMultipleSelectionDuringEditing = YES;
        [btn setTitle:@"咨询" forState:UIControlStateNormal];
        for (NSInteger i = 0; i < self.dataArr.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self changeCellEditingStyleColor:indexPath];
        }
    
    }else {
        _isAllSelected = NO;
        [btn setTitle:@"选择异常项咨询" forState:UIControlStateNormal];
        NSArray *rows = [self.tableView indexPathsForSelectedRows];
        NSString *resultStr = @"";
        for (NSIndexPath *indexPath in rows) {
            
            CheckResult *result = self.dataArr[indexPath.row];
            NSString *reportItemStr = [NSString stringWithFormat:@"[%@:%@]",result.CheckIndexName,result.ResultValue];
            resultStr = [resultStr stringByAppendingString:[NSString stringWithFormat:@"%@\n",reportItemStr]];
        }
        
        //删除最后的\n
        resultStr = [resultStr substringToIndex:resultStr.length - 1];
        NSLog(@"_______finallStr:%@",resultStr);
        
        MBProgressHUD *hud = [CommonUtil createHUD];
        NSString *accountId = [[UserManager shareInstance] getUserInfo].accountId;
        
        /*[ChatModel SendForReport:accountId content:resultStr checkUnitCode:self.report.CheckUnitCode workNo:self.report.WorkNo checkUnitName:self.report.CheckUnitName reportDate:self.report.ReportDateFormat callBackBlock:^(HttpRequestResult<NSMutableArray<ChatData *> *> *httpResult) {
            
            hud.hidden = YES;
            if (httpResult.IsSuccess) {
                //数据请求成功 传数据进入咨询界面
                [self.chatDataArr addObjectsFromArray:httpResult.Data];
                [self goChatView];
            }else {
                [CommonUtil showHUDWithTitle:httpResult.Message];
            }
        }];*/
        
        [ChatModel SendForReport:accountId content:resultStr checkUnitCode:self.report.CheckUnitCode workNo:self.report.WorkNo checkUnitName:self.report.CheckUnitName reportDate:self.report.ReportDateFormat callBackBlock:^(HttpRequestResult<ZSBoolType *> *httpResult) {
            
            hud.hidden = YES;
            if (httpResult.IsSuccess) {
                //数据请求成功 传数据进入咨询界面
                [self goChatView];
            }else {
                [CommonUtil showHUDWithTitle:httpResult.Message];
            }
        }];
    }
}

- (void)goChatView {
    ConsultDetailViewController *consultController;
    for(UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ConsultDetailViewController class]]) {
            consultController=(ConsultDetailViewController *)vc;
            break;
        }
    }
    if(!consultController){
        consultController=[[ConsultDetailViewController alloc] init];
        [self.navigationController pushViewController:consultController animated:YES];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshConsultListKVOKey object:nil];
        [self.navigationController popToViewController:consultController animated:YES];
    }
    
    
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CheckResult *result = self.dataArr[indexPath.row];
    ReportItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportItemCell"];
    cell.selectedBackgroundView = [[UIView alloc] init];
    [cell showDataWithModel:result];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckResult *result = self.dataArr[indexPath.row];
    
    CGFloat valueLabelH = [CommonUtil getHeightWithFont:[UIFont systemFontOfSize:14] title:result.ResultValue maxWidth:kScreenSizeWidth - 30];
    CGFloat titleLableH = [CommonUtil getHeightWithFont:[UIFont systemFontOfSize:15] title:result.CheckIndexName maxWidth:kScreenSizeWidth - 30];
    return 55 - 35 + valueLabelH + titleLableH;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self changeCellEditingStyleColor:indexPath];
}

- (void)changeCellEditingStyleColor:(NSIndexPath *)indexPath {
    NSArray *subViews = [[self.tableView cellForRowAtIndexPath:indexPath] subviews];
    
    for (id obj in subViews) {
        if ([obj isKindOfClass:[UIControl class]]) {
            
            for (id subView in [obj subviews]) {
                if ([subView isKindOfClass:[UIImageView class]]) {
                    
                    UIImageView *imageView = (UIImageView *)subView;
                    imageView.image = [UIImage imageNamed:@"selected_cell"];
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
