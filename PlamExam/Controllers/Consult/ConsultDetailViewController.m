//
//  ConsulationViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#define kRecordViewH (kScreenSizeWidth > 375 ? 210 :200)
#define kDoctorFloatViewH 100
#define kToolBarH 46

#import "ConsultDetailViewController.h"
#import "DoctorInfoView.h"
#import "HZRecognizerView.h"
#import "CommonUtil.h"
#import "DoctorReplyCell.h"
#import "UserTextCell.h"
#import "UserReportCell.h"
#import "ChatModel.h"
#import "ChatData.h"
#import "DoctorManager.h"
#import "UserManager.h"
#import "User.h"
#import "CommentViewController.h"
#import "ReportListViewController.h"
#import <UIImageView+WebCache.h>

@interface ConsultDetailViewController ()
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

@property (nonatomic, assign) CGFloat previousTextViewHeight;
@property (nonatomic, assign) CGFloat contentOffsetY;

@end

@implementation ConsultDetailViewController


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
        _doctorInfoView.backgroundColor = [UIColor clearColor];
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
    self.dataArr=[[NSMutableArray<ChatData*> alloc] init];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kClearBadgeKVOKey object:nil];
    self.navigationItem.title = @"健康咨询服务";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadConsultListNotification:) name:kRefreshConsultListKVOKey object:nil];
    
    [self.textView setRound];
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewClick:)]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kSetRGBColor(242, 242, 242);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DoctorReplyCell" bundle:nil] forCellReuseIdentifier:@"DoctorReplyCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserTextCell" bundle:nil] forCellReuseIdentifier:@"UserTextCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserReportCell" bundle:nil] forCellReuseIdentifier:@"UserReportCell"];
    
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self loadChatData];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.fromReportArr.count != 0) {
        self.dataArr=[NSMutableArray<ChatData*> array];
        //有值
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:self.fromReportArr];
        [self.fromReportArr removeAllObjects];

        [self.tableView reloadData];
        [self scrollToBottom:YES];
        
    }else{
        //没有值， 需要判断有没有实例
        if (!self.dataArr) {
            [self loadChatData];
        }else {
            
        }
    }
}
 */

- (void)setUpDoctorInfoWithModel:(Doctor *)doctor {
    
    DoctorInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"DoctorInfoView" owner:self options:nil] lastObject];
    infoView.frame = self.doctorInfoView.bounds;
    infoView.nameLabel.text = doctor.realName;
    infoView.descriptionLabel.text = doctor.speciality;
    [infoView.iconImageView sd_setImageWithURL:[NSURL URLWithString:doctor.imageSrc] placeholderImage:[UIImage imageNamed:@"default"]];
    [self.doctorInfoView addSubview:infoView];
}

-(void) loadConsultListNotification:(NSNotification*)notification{
    [self loadChatData];
}

//获取聊天记录
- (void)loadChatData {
    self.dataArr = [NSMutableArray array];
    MBProgressHUD *hud = [CommonUtil createHUD];
    
    NSString* accountId=[[UserManager shareInstance] getUserInfo].accountId;
    
    if(![[DoctorManager shareInstance] existDoctorId] && ![[DoctorManager shareInstance] existDoctorList]){
        [ChatModel requestChatDataAndDoctorIdAndDoctorList:accountId chatDataCallback:^(HttpRequestResult<NSMutableArray<ChatData *> *> *httpRequestResult) {
            //获取聊天记录
            if (httpRequestResult.IsSuccess) {
                if(!self.dataArr){
                    self.dataArr=[[NSMutableArray<ChatData*> alloc] init];
                }
                else{
                    [self.dataArr removeAllObjects];
                }
                [self.dataArr addObjectsFromArray:httpRequestResult.Data];
                
                [self.tableView reloadData];
                [self scrollToBottom:NO];
            }
            
        } doctorIdCallback:^(HttpRequestResult<ZSIntType *> *httpRequestResult) {
            //获取健管师Id
            if (httpRequestResult.IsSuccess) {
                [[DoctorManager shareInstance] setCurrentDoctorId:httpRequestResult.Data.Value];
            }
        } doctorListCallback:^(HttpRequestResult<NSMutableArray<Doctor *> *> *httpRequestResult) {
            if (httpRequestResult.IsSuccess) {
                [[DoctorManager shareInstance] setDoctors:httpRequestResult.Data];
            }
        } allFinishCallback:^(BOOL isAllSuccess) {
            hud.hidden = YES;
            if (isAllSuccess) {
                Doctor *doctor = [[DoctorManager shareInstance] getCurrentDoctor];
                [self setUpDoctorInfoWithModel:doctor];
            }else {
                [CommonUtil showHUDWithTitle:@"部分数据请求失败"];
            }
        }];
    }
    else if (![[DoctorManager shareInstance] existDoctorId]){
        [ChatModel requestChatDataAndDoctorId:accountId chatDataCallback:^(HttpRequestResult<NSMutableArray<ChatData *> *> *httpRequestResult) {
            //获取聊天记录
            if (httpRequestResult.IsSuccess) {
                if(!self.dataArr){
                    self.dataArr=[[NSMutableArray<ChatData*> alloc] init];
                }
                else{
                    [self.dataArr removeAllObjects];
                }
                [self.dataArr addObjectsFromArray:httpRequestResult.Data];
                
                [self.tableView reloadData];
                [self scrollToBottom:NO];
            }
        } doctorIdCallback:^(HttpRequestResult<ZSIntType *> *httpRequestResult) {
            if (httpRequestResult.Message) {
                [[DoctorManager shareInstance] setCurrentDoctorId:httpRequestResult.Data.Value];
            }
        } allFinishCallback:^(BOOL isAllSuccess) {
            if (isAllSuccess) {
                Doctor *doctor = [[DoctorManager shareInstance] getCurrentDoctor];
                [self setUpDoctorInfoWithModel:doctor];
            }else {
                [CommonUtil showHUDWithTitle:@"部分数据请求失败"];
            }
        }];
    }
    else{
        [ChatModel requestChatDataWithAccountId:accountId callBackBlock:^(HttpRequestResult<NSMutableArray<ChatData *> *> *httpRequestResult) {
           
            hud.hidden = YES;
            Doctor *doctor = [[DoctorManager shareInstance] getCurrentDoctor];
            [self setUpDoctorInfoWithModel:doctor];
            
            if (httpRequestResult.IsSuccess) {
                if(!self.dataArr){
                    self.dataArr=[[NSMutableArray<ChatData*> alloc] init];
                }
                else{
                    [self.dataArr removeAllObjects];
                }
                [self.dataArr addObjectsFromArray:httpRequestResult.Data];
                [self.tableView reloadData];
                [self scrollToBottom:NO];
            }else {
                [CommonUtil showHUDWithTitle:httpRequestResult.Message];
            }
        }];
    }
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
   // return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ChatData *chatData = self.dataArr[indexPath.row];
    if ([chatData.SourceType integerValue] == 1) {
        //用户的消息
        if ([chatData.Type integerValue] == kReportConsultType) {
            //体检报告
            UserReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserReportCell"];
            [cell showDataWithModel:chatData];
            return cell;
        }else {
            //普通文字
            UserTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTextCell"];
            [cell showDataWithModel:chatData];
            return cell;
        }

    }else {
        //健管师发送的消息
        DoctorReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorReplyCell"];
        [cell showDataWithModel:chatData];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatData *chatData = self.dataArr[indexPath.row];
    if ([chatData.Type integerValue] == kReportConsultType) {
        return chatData.reportCellHeight;
    }else {
        return chatData.textCellHeight;
    }
    
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
    }
}


//隐藏用户信息View
- (void) hiddenUserInfoView {
    [UIView animateWithDuration:0.4 animations:^{
    CGRect frame = self.doctorInfoView.frame;
    frame.origin.y = - (kDoctorFloatViewH - 20 - 64);
    self.doctorInfoView.frame = frame;
        

    //修改tableView的frame
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.origin.y = kNavigationBarH + 20;
    tableViewFrame.size.height = kScreenSizeHeight - kToolBarH - kNavigationBarH -20;
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
- (void)sendMessage:(NSString *)text type:(NSInteger)type{
    
    if ([CommonUtil isBlankString:text]) {
        [CommonUtil showHUDWithTitle:@"不能发送空白消息"];
        self.textView.text = @"";
        return;
    }
    User *user = [[UserManager shareInstance] getUserInfo];
    
    [ChatModel sendMessage:user.accountId type:type consultContent:text appendInfo:@"" callBackBlock:^(HttpRequestResult<NSString *> *httpResult) {

        if (httpResult.IsHttpSuccess) {
            if (httpResult.HttpResult.Code == 1) {
                NSLog(@"_____data:%@",httpResult.Data.description);
                
                ChatData *sendData = [[ChatData alloc] init];
                sendData.SourceType = @"1";
                sendData.Content = text;
                sendData.Type = [NSString stringWithFormat:@"%ld",type];
                
                [self.dataArr addObject:sendData];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [self scrollToBottom:YES];
                
                self.textView.text = @"";
                _placeholderLabel.hidden = NO;
                [self textViewDidChange:self.textView];
                
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
        
        [self sendMessage:textStr type:1];
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
//tableView 被点击
- (void)tableViewClick:(UITapGestureRecognizer *)tap {
    [self.textView resignFirstResponder];
}
//评论按钮被点击  跳转
- (IBAction)commentClick:(id)sender {
    [self.textView resignFirstResponder];
    
    CommentViewController *comment = [[CommentViewController alloc] init];
    
    [self.navigationController pushViewController:comment animated:YES];
}

//体检报告按钮被点击
- (IBAction)reportBtnClick:(id)sender {
    [self.textView resignFirstResponder];
    
    ReportListViewController *reportList = [[ReportListViewController alloc] init];
    
    [self.navigationController pushViewController:reportList animated:YES];
}

//发送消息
- (IBAction)senMessageBtnClick:(id)sender {
    [self sendMessage:self.textView.text type:1];
    
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
