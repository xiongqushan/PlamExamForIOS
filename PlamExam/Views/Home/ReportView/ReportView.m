//
//  ReportView.m
//  ReportTableViewDemo
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportView.h"
#import "ReportItemCell.h"
#import "ReportInfo.h"
#import "UIColor+Utils.h"
#import "UIView+Utils.h"
#import "SummaryFormatCell.h"

#define kleftViewWidth 150

@interface ReportView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *leftTableView;

@end

@implementation ReportView
{
    BOOL _isShowLeftView;
    UITapGestureRecognizer *_tap;
    UIButton *_floatBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self setUpLeftView];
//        [self setUpTableView];
    }
    
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    
    [self setUpLeftView];
    [self setUpTableView];
}

- (void)setUpLeftView {
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -1, kleftViewWidth, self.bounds.size.height+1)];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    leftTableView.layer.borderWidth = 1.0;
    leftTableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:leftTableView];
    [leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultCell"];

    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kleftViewWidth, 60)];
    headerView.textColor = [UIColor textColor];
    headerView.textAlignment = NSTextAlignmentCenter;
    headerView.text = [NSString stringWithFormat:@"体检项目 (%ld) ",self.dataArr.count];
    leftTableView.tableHeaderView = headerView;
    
    self.leftTableView = leftTableView;
}

- (void)setUpTableView {
  //  self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
   // self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor colorWithHex:0xF2F2F2];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReportItemCell" bundle:nil] forCellReuseIdentifier:@"ReportItemCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SummaryFormatCell" bundle:nil] forCellReuseIdentifier:@"SummaryFormatCell"];
    
//    self.tableView.backgroundColor = [UIColor viewBackgroundColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewClick)];
//    _tap = tap;
//    
//    if (!(self.dataArr.count == 0)) {
//        //添加浮动按钮
//        UIButton *floatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [floatBtn setBackgroundImage:[UIImage imageNamed:@"floatingBtn"] forState:UIControlStateNormal];
//        floatBtn.frame = CGRectMake(self.bounds.size.width - 80, self.bounds.size.height - 140, 44, 44);
//        [floatBtn addTarget:self action:@selector(floatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:floatBtn];
//        _floatBtn = floatBtn;
//    }

}

//#pragma mark -- 浮动按钮被点击
//- (void)floatBtnClick:(UIButton *)btn {
//    
//    _isShowLeftView = !_isShowLeftView;
//    if (_isShowLeftView) {
//        //显示左侧列表
//        //获取tableView的偏移量
//        CGPoint offset = self.tableView.contentOffset;
//        NSIndexPath *tableViewIndexPath = [self.tableView indexPathForRowAtPoint:offset];
//        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:tableViewIndexPath.section inSection:0];
//        [self.leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
//
//        [UIView animateWithDuration:0.25 animations:^{
//            self.tableView.frame = CGRectMake(kleftViewWidth, 0, self.bounds.size.width, self.bounds.size.height);
//            btn.transform = CGAffineTransformRotate(btn.transform, -M_PI_4);
//        }];
//        
//        [self.tableView addGestureRecognizer: _tap];
//        
//    }else {
//        [UIView animateWithDuration:0.25 animations:^{
//            self.tableView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//            btn.transform = CGAffineTransformRotate(btn.transform, M_PI_4);
//        }];
//        [self.tableView removeGestureRecognizer:_tap];
//    }
//}
//
//- (void)tableViewClick {
//    _isShowLeftView = NO;
//    [UIView animateWithDuration:0.25 animations:^{
//        self.tableView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//        _floatBtn.transform = CGAffineTransformRotate(_floatBtn.transform, M_PI_4);
//    }];
//    [self.tableView removeGestureRecognizer:_tap];
//}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return self.dataArr.count;
    }
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.tableView) {
        //如果小结有数据 多插入一行cell
        CheckItem *items = self.dataArr[section];
        if (items.SummaryFormat) {
            return items.CheckResults.count + 1;
        }
        
        return items.CheckResults.count;
    }
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (tableView == self.tableView) {
        CheckItem *items = self.dataArr[indexPath.section];
        //当数组个数等于滑动到cell的index 说明是小结对应的cell
        if (items.CheckResults.count == indexPath.row) {
            SummaryFormatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SummaryFormatCell"];
            cell.summaryLabel.text = [NSString stringWithFormat:@"小结:%@",items.SummaryFormat];
            return cell;
        }
        
        CheckResult *result = items.CheckResults[indexPath.row];
        ReportItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportItemCell"];
        [cell showDataWithModel:result];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
    CheckItem *items = self.dataArr[indexPath.row];
    cell.textLabel.text = items.CheckItemName;
    cell.textLabel.textColor = [UIColor textColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = kSetRGBColor(40, 170, 238);
    return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
        CheckItem *items = self.dataArr[indexPath.section];
        //当数组个数等于滑动到cell的index 说明是小结对应的cell
        if (items.CheckResults.count == indexPath.row) {
            CGFloat cellHeight  = [CommonUtil getHeightWithFont:[UIFont systemFontOfSize:15] title:[NSString stringWithFormat:@"小结:%@",items.SummaryFormat] maxWidth:kScreenSizeWidth - 30];
            return cellHeight + 18;
        }
        
        CGFloat valueLabelH = [CommonUtil getHeightWithFont:[UIFont systemFontOfSize:14] title:items.CheckResults[indexPath.row].ResultValue maxWidth:kScreenSizeWidth - 30];
        CGFloat titleLableH = [CommonUtil getHeightWithFont:[UIFont systemFontOfSize:15] title:items.CheckResults[indexPath.row].CheckIndexName maxWidth:kScreenSizeWidth - 30];
        return 55 - 35 + valueLabelH + titleLableH;
    }
    
    return 44;
}

//创建分区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return nil;
    }
    
    CheckItem *item = self.dataArr[section];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 44)];
    headerView.backgroundColor = kSetRGBColor(123, 191, 247);
    headerView.tag = 200 + section;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionClick:)];
    [headerView addGestureRecognizer:tap];
    _tap = tap;
    
    UILabel *imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, 3, 18)];
    imageLabel.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:imageLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 7, kScreenSizeWidth - 65, 30)];
    titleLabel.text = item.CheckItemName;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [headerView addSubview:titleLabel];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSizeWidth - 34, 12, 20, 20)];
    rightImageView.image = [UIImage imageNamed:@"menu"];
    [headerView addSubview:rightImageView];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return 0;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        _isShowLeftView = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.frame = self.bounds;
            //_floatBtn.transform = CGAffineTransformRotate(_floatBtn.transform, M_PI_4);
        }];
        
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [self.tableView scrollToRowAtIndexPath:indexPath2 atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- 分区头视图被点击
//分区头视图被点击
- (void)sectionClick:(UITapGestureRecognizer *)tap {
    _isShowLeftView = !_isShowLeftView;
    
    if (_isShowLeftView) {
        //获取tableView的偏移量
        CGPoint offset = self.tableView.contentOffset;
        NSIndexPath *tableViewIndexPath = [self.tableView indexPathForRowAtPoint:offset];
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:tableViewIndexPath.section inSection:0];
        [self.leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.frame = CGRectMake(kleftViewWidth, 0, self.bounds.size.width, self.bounds.size.height);
        }];
        
        [self.tableView addGestureRecognizer: _tap];
        
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        }];
        [self.tableView removeGestureRecognizer:_tap];
    }

}


@end
