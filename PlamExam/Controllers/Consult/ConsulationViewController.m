//
//  ConsulationViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#define kRecordViewH (kScreenSizeWidth > 375 ? 210 :200)
#define kDoctorFloatViewH 90
#define kToolBarH 46

#import "ConsulationViewController.h"
#import "DoctorInfoView.h"
#import "HZRecognizerView.h"
#import "CommonUtil.h"
#import "DoctorReplyCell.h"
#import "ChatModel.h"
#import "ChatData.h"
#import "ReportListViewController.h"

@interface ConsulationViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarHeightConstraint;

@property (nonatomic, strong) UIView *doctorInfoView;   //健管师简介View
@property (nonatomic, strong) HZRecognizerView *recordView;    //语音识别View
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) CGFloat previousTextViewHeight;
@property (nonatomic, assign) CGFloat contentOffsetY;

@end

@implementation ConsulationViewController

- (CGFloat)previousTextViewHeight {
    if (_previousTextViewHeight == 0) {
        _previousTextViewHeight = self.textView.frame.size.height;
    }
    return _previousTextViewHeight;
}

- (UIView *)doctorInfoView {
    if (!_doctorInfoView) {
        _doctorInfoView = [[UIView alloc] init];
        _doctorInfoView.frame = CGRectMake(0, kNavigationBarH, kScreenSizeWidth, kDoctorFloatViewH);
        [self.view addSubview:_doctorInfoView];
    }
    return _doctorInfoView;
}

- (UIView *)recordView {
    if (!_recordView) {
        _recordView = [[HZRecognizerView alloc] initWithFrame:CGRectMake(0, kScreenSizeHeight, kScreenSizeWidth, kRecordViewH)];
        _recordView.backgroundColor = [UIColor whiteColor];
        _recordView.clipsToBounds = YES;
        [self.view addSubview:_recordView];
    }
    return _recordView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"健康咨询服务";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.textView setRound];
    //获取聊天记录
    [self loadChatData];
    
    DoctorInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"DoctorInfoView" owner:self options:nil] lastObject];
    infoView.frame = self.doctorInfoView.bounds;
    [self.doctorInfoView addSubview:infoView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DoctorReplyCell" bundle:nil] forCellReuseIdentifier:@"DoctorReplyCell"];
    
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

//获取聊天记录
- (void)loadChatData {
    self.dataArr = [NSMutableArray array];
    
    [ChatModel requestChatDataWithAccountId:@"sample string 1" callBackBlock:^(HttpRequestResult<NSMutableArray *> *httpResult) {
        if (httpResult.IsHttpSuccess) {
            if (httpResult.HttpResult.Code == 1) {
                NSLog(@"_____%@",httpResult.Data.description);
                self.dataArr = httpResult.Data;
                [self.tableView reloadData];
                [self scrollToBottom:NO];
            }else {
                [CommonUtil showHUDWithTitle:httpResult.HttpResult.Message];
            }
        }else {
            [CommonUtil showHUDWithTitle:httpResult.HttpMessage];
        }
    }];
}

#pragma mark -- 监听键盘的触发事件
//当键盘将要显示
- (void)kbWillShow:(NSNotification *)note {
    
    self.voiceBtn.selected = NO;
    [self.recordView stopRecognizer];
    
    //1.获取键盘高度
    //1.1获取键盘结束时候的位置
    CGRect kbEndFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kbHeight = kbEndFrame.size.height;
    
    CGRect beginRect = [[note.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endRect = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //第三方键盘回调三次问题，监听最后一次
    if (!(beginRect.size.height > 0 && (beginRect.origin.y - endRect.origin.y > 0))) {
        return;
    }
    
    CGFloat animationDuration = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //2.更改ToolBar底部约束
    self.toolBarBottomConstraint.constant = kbHeight;
    
    //添加动画
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
    [self scrollToBottom:NO];

}

//当键盘收起
- (void)kbWillHide:(NSNotification *)nodte {
    
    self.toolBarBottomConstraint.constant = 0;
    
    [self.recordView removeFromSuperview];
    self.recordView = nil;
}

//滑动tableView到底部
- (void)scrollToBottom:(BOOL)animated {
    
    if (self.dataArr.count == 0) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    ChatData *model = self.dataArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@，第%ld行",model.Content,indexPath.row];
    return cell;
}

#pragma mark --UIScrollerViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.textView) {
        return;
    }
    
    //停止语音识别
    [self.recordView stopRecognizer];
    self.voiceBtn.selected = NO;
    
    //隐藏语音识别视图
    [UIView animateWithDuration:0.25 animations:^{
        self.recordView.frame = CGRectMake(0, kScreenSizeHeight, kScreenSizeWidth, kRecordViewH);
    }];
    
    [self.view endEditing:YES];
    self.toolBarBottomConstraint.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

if (scrollView == self.tableView) {
        CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
        if (translation.y>0) {

            NSLog(@"______向下滑动，显示View");
            [self showUserInfoView];
        }else if(translation.y<0){

            NSLog(@"______向上滑动，隐藏View");
            [self hiddenUserInfoView];
        }

//滑动时，textView如果是第一响应者，取消
//        if (self.textView.isFirstResponder) {
//            [self.textView resignFirstResponder];
//        }
//
//        [UIView animateWithDuration:0.25 animations:^{
//            self.voiceView.frame = CGRectMake(0, kScreenSizeHeight, kScreenSizeWidth, kVoiceHeight);
//
//            self.view.transform = CGAffineTransformMakeTranslation(0, 0);
//        }];
//
//        [UIView animateWithDuration:0.25 animations:^{
//            self.toolBar.sd_layout.bottomSpaceToView(self.view,0);
//            [self.toolBar updateLayout];
//        }];


}
}


//隐藏用户信息View
- (void) hiddenUserInfoView {
    [UIView animateWithDuration:0.4 animations:^{
    CGRect frame = self.doctorInfoView.frame;
    frame.origin.y = -6;
    self.doctorInfoView.frame = frame;
        

    //修改tableView的frame
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.origin.y = kNavigationBarH;
    tableViewFrame.size.height = kScreenSizeHeight - kToolBarH - kNavigationBarH;
    self.tableView.frame = tableViewFrame;
    }];

  //  _userViewIsHidden = YES;
}

//显示用户信息View
- (void)showUserInfoView {
    [UIView animateWithDuration:0.4 animations:^{
    CGRect frame = self.doctorInfoView.frame;
    frame.origin.y = kNavigationBarH;
    self.doctorInfoView.frame = frame;
        

    //修改tableView的frame
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.origin.y = kNavigationBarH + kDoctorFloatViewH;
    tableViewFrame.size.height = kScreenSizeHeight - kNavigationBarH - kToolBarH - kDoctorFloatViewH;
    self.tableView.frame = tableViewFrame;
    }];

   // _userViewIsHidden = NO;
}

#pragma mark -- 发送消息
- (void)sendMessage:(NSString *)text {
//    if ([HZUtils isBlankString:text]) {
//        [HZUtils showHUDWithTitle:@"不能发送空白消息"];
//        self.textView.text = @"";
//        return;
//    }
//    HZUser *user = [Config getProfile];
//    NSDate *date = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSString *currentDate = [dateFormatter stringFromDate:date];
//    
//    NSDictionary *param = @{@"DoctorId":_infoModel.doctorID,@"ReDoctorId":user.doctorId,@"ReDoctorName":user.name,@"CustomerId":self.customId,@"ReplyContent":text,@"ReplyTime":currentDate};
//    [ChartHttpRequest replyMessage:param completionBlock:^(ChartModel *model, NSString *message) {
//        
//        if (message) {
//            // [HZUtils showHUDWithTitle:message];
//        }else {
//            
//            [self.dataArr insertObject:model atIndex:0];
//            
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0];
//            [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            
//            NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0];
//            [_tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeListNotifi" object:nil];
//            
//            //回复成功
//            _textView.text = @""; // 将textView内容清空
//            _placeholderLabel.hidden = NO;
//            [self textViewDidChange:_textView]; //将textView的高度恢复默认
//        }
//    }];
    
    [ChatModel sendMessageWithAccountId:@"sample string 1" type:2 consultContent:@"sapmle string 3" appendInfo:@"sample string 4" consultDate:@"2016-10-17T19:30:51.1970415+08:00" callBackBlock:^(HttpRequestResult<NSString *> *httpResult) {

        if (httpResult.IsHttpSuccess) {
            if (httpResult.HttpResult.Code == 1) {
                NSLog(@"_____%@",httpResult.Data.description);
            }else {
                [CommonUtil showHUDWithTitle:httpResult.HttpResult.Message];
            }
        }else {
            [CommonUtil showHUDWithTitle:httpResult.HttpMessage];
        }
    }];
    
}

#pragma mark -- UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (![text isEqualToString:@""]) {
        self.placeholderLabel.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        self.placeholderLabel.hidden = NO;
    }
    
    if ([text isEqualToString:@"\n"]) {
        
        //把textView的内容封装到model中，并添加到可变数组
        NSString *textStr = textView.text;
        
        [self sendMessage:textStr];
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    //1.计算textView的高度
    CGFloat textViewH = 0;
    CGFloat minHeight = 33 + 3;   //textView最小的高度
    CGFloat maxHeight = 83 +3 +10;  //textView最大的高度
    
    //获取contentSize 的高度
    CGFloat contentHeight = textView.contentSize.height;
    
    if (contentHeight < minHeight) {
        textViewH = minHeight;
        [textView setContentInset:UIEdgeInsetsZero];
    }else if (contentHeight > maxHeight) {
        textViewH = maxHeight + 4.5;
        [textView setContentInset:UIEdgeInsetsMake(-5, 0, -3.5, 0)];
    }else {
        if (contentHeight == minHeight) {
            [textView setContentInset:UIEdgeInsetsZero];
            textViewH = minHeight;
        }else {
            textViewH = contentHeight - 8;
            [textView setContentInset:UIEdgeInsetsMake(-4.5, 0, -4.5, 0)];
        }
    }
    
    //3.调整整个InputToolBar的高度
    self.toolBarHeightConstraint.constant = 5 + 5 + textViewH;
    CGFloat changeH = textViewH - self.previousTextViewHeight;
    if (changeH != 0) {
        //加个动画
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
            if (textView.text.length) {
                [self scrollToBottom:NO];
            }
            // 下面这几行代码需要写在[self.view layoutIfNeeded]后面，不然系统会自动调整为位置
            if (contentHeight < maxHeight) {
                [textView setContentOffset:CGPointZero animated:YES];
                [textView scrollRangeToVisible:textView.selectedRange];
            }
        }];
        self.previousTextViewHeight = textViewH;
    }
    
    if (contentHeight > maxHeight) {
        [UIView animateWithDuration:0.2 animations:^{
            if (self.contentOffsetY) {
                if (textView.selectedRange.location != textView.text.length && textView.contentOffset.y != self.contentOffsetY) return;
            }

            [textView setContentOffset:CGPointMake(0.0, textView.contentSize.height - textView.frame.size.height - 3.5)];
            self.contentOffsetY = textView.contentOffset.y;
        }];
        [textView scrollRangeToVisible:textView.selectedRange];
    }
}


#pragma mark -- 点击事件
//体检报告按钮被点击
- (IBAction)reportBtnClick:(id)sender {
    ReportListViewController *reportList = [[ReportListViewController alloc] init];
    
    [self.navigationController pushViewController:reportList animated:YES];
}

//语音识别按钮被点击
- (IBAction)voiceBtnClick:(id)sender {
    UIButton *recordBtn = (UIButton *)sender;
    recordBtn.selected = !recordBtn.selected;
    
    if (recordBtn.selected) {
        //显示recordView
        [self.view endEditing:YES];
        [self.recordView starRecognizerResult:^(NSString *result, NSString *errorDesc) {
            if (errorDesc) {
                [CommonUtil showHUDWithTitle:errorDesc];
                [self.recordView stopRecognizer];
            }else {
                self.textView.text = [self.textView.text stringByAppendingString:result];
                if (![result isEqualToString:@""]) {
                    self.placeholderLabel.hidden = YES;
                }
            }  
            
        }];
        self.toolBarBottomConstraint.constant = kRecordViewH;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.recordView.frame = CGRectMake(0, kScreenSizeHeight - kRecordViewH, kScreenSizeWidth, kRecordViewH);
            [self.view layoutIfNeeded];
        }];
        
        [self scrollToBottom:NO];
        
    }else {
        //隐藏语音识别视图
        [self.recordView removeFromSuperview];
        self.recordView = nil;
        
        [self.textView becomeFirstResponder];
        
        [self.recordView stopRecognizer];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.recordView stopRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
