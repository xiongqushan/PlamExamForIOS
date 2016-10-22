//
//  ReportAnalyViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportAnalyViewController.h"
#import "AnalyCell.h"
#import "ReportInfo.h"
#import "UIColor+Utils.h"

@interface ReportAnalyViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ReportAnalyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
}

- (void)setUpTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight - 64 - 55) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithHex:0xF2F2F2];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerNib:[UINib nibWithNibName:@"AnalyCell" bundle:nil] forCellReuseIdentifier:@"AnalyCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GeneralAdvice *advice = self.dataArr[indexPath.row];
    
    AnalyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnalyCell" forIndexPath:indexPath];
    cell.nameLabel.text = advice.AdviceName;
    cell.contentLabel.text = advice.AdviceDescription;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GeneralAdvice *advice = self.dataArr[indexPath.row];
    
//    CGFloat nameLabelH = [CommonUtil getHeightWithFont:[UIFont systemFontOfSize:16] title:advice.AdviceName maxWidth:kScreenSizeWidth - 30];
    CGFloat descriptionLabelH = [CommonUtil getHeightWithFont:[UIFont systemFontOfSize:14] title:advice.AdviceDescription maxWidth:kScreenSizeWidth - 30];
    
    return 72 - 17 + descriptionLabelH;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
