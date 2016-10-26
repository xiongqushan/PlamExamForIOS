//
//  CommentViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "CommentViewController.h"
#import "HYBStarEvaluationView.h"
#import "DoctorInfoView.h"
#import "DoctorManager.h"
#import "ChatModel.h"
#import "UserManager.h"

#define kCommentTagH 

@interface CommentViewController () <DidChangedStarDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *doctorInfoView;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UIView *commentTagsView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *forthBtn;
@property (weak, nonatomic) IBOutlet UILabel *placholderLabel;

@property (nonatomic, strong) HYBStarEvaluationView *HYBStarView;

@property (nonatomic, strong) NSMutableArray *commitTagsArr;

@end

@implementation CommentViewController

//提交评价
- (IBAction)submitComment:(id)sender {
    [self.textView resignFirstResponder];
    
    User *user = [[UserManager shareInstance] getUserInfo];
    if (!user.accountId) {
        [CommonUtil showHUDWithTitle:@"请先登录！"];
        return;
    }
    
    NSString *content = self.textView.text;
    if (self.commitTagsArr.count != 0) {
        NSString *temp = @"";
        
        for (NSString *str in self.commitTagsArr) {
            temp = [temp stringByAppendingString:[NSString stringWithFormat:@"%@ ",str]];
        }
        content = [temp stringByAppendingString:self.textView.text];
    }
    
    [ChatModel Comment:user.accountId score:[NSString stringWithFormat:@"%f",_HYBStarView.actualScore] content:content callBackBlock:^(HttpRequestResult<ZSBoolType *> *httpResult) {
        if (httpResult.IsSuccess) {
            
            if (httpResult.Data.Value) {
              
                [CommonUtil showHUDWithTitle:@"感谢您的评价"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else {
            [CommonUtil showHUDWithTitle:httpResult.Message];
        }
    }];
}

- (NSMutableArray *)commitTagsArr {
    if (!_commitTagsArr) {
        self.commitTagsArr = [NSMutableArray array];
    }
    return _commitTagsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setUpCommentTagBtn];
    
    //注册关于键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHiden:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘显示
- (void)kbWillShow:(NSNotification *)note {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -220);
    }];
}

//键盘隐藏
- (void)kbWillHiden:(NSNotification *)note {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

//设置评价标签的样式
- (void)setUpCommentTagBtn {
    [self.firstBtn setBorder];
    [self.secondBtn setBorder];
    [self.thirdBtn setBorder];
    [self.forthBtn setBorder];
    
    [self.textView setBorder];
}

//初始化一些控件的样式
- (void)initUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *doctorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 100)];
    doctorView.backgroundColor = [UIColor redColor];
    [self.bgView addSubview:doctorView];
    
    Doctor *doctor = [[DoctorManager shareInstance] getCurrentDoctor];
    DoctorInfoView *doctorInfo = [[[NSBundle mainBundle] loadNibNamed:@"DoctorInfoView" owner:self options:nil] lastObject];
    doctorInfo.frame = doctorView.bounds;
    [doctorInfo showDataWithModel:doctor];
    [doctorView addSubview:doctorInfo];
    
    HYBStarEvaluationView *starView = [[HYBStarEvaluationView alloc] initWithFrame:CGRectMake(0, 0, 175, 30) numberOfStars:5 isVariable:YES];
    starView.actualScore = 5;
    starView.fullScore = 5;
    starView.delegate = self;
    _HYBStarView = starView;
    [self.starView addSubview:starView];
    
    [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)]];
    
}

- (void)hidenKeyboard {
    [self.textView resignFirstResponder];
}

- (IBAction)commitBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        //选中
        [btn setBackgroundColor:kSetRGBColor(250, 162, 75)];
       // [btn setTintColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.commitTagsArr addObject:btn.titleLabel.text];
    }else {
        //未选中
        [btn setBackgroundColor:[UIColor whiteColor]];
       // [btn setTintColor:kSetRGBColor(153, 153, 153)];
        [btn setTitleColor:kSetRGBColor(153, 153, 153) forState:UIControlStateNormal];
        [self.commitTagsArr removeObject:btn.titleLabel.text];
    }

}

- (void)didChangeStar {
    NSLog(@"这次星级为: %f",_HYBStarView.actualScore);
}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"这次星级为: %f",_HYBStarView.actualScore);
//}

#pragma mark -- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        self.placholderLabel.text = @"请输入您对此次服务的总评价";
    }else {
        self.placholderLabel.text = @"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
