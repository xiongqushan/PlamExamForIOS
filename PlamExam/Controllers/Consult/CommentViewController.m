//
//  CommentViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "CommentViewController.h"
#import "HYBStarEvaluationView.h"

#define kCommentTagH 

@interface CommentViewController () <DidChangedStarDelegate>

@property (weak, nonatomic) IBOutlet UIView *doctorInfoView;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UIView *commentTagsView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic, strong) HYBStarEvaluationView *HYBStarView;

@end

@implementation CommentViewController

- (IBAction)submitComment:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    HYBStarEvaluationView *starView = [[HYBStarEvaluationView alloc] initWithFrame:CGRectMake(0, 0, 175, 30) numberOfStars:5 isVariable:YES];
    starView.actualScore = 5;
    starView.fullScore = 5;
    starView.delegate = self;
    _HYBStarView = starView;
    [self.starView addSubview:starView];
    
    
//    for (NSInteger i = 0; i < 2; i++) {
//        for (NSInteger j = 0; j < 2; j++) {
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//        }
//    }
    
}


- (void)didChangeStar {
    NSLog(@"这次星级为: %f",_HYBStarView.actualScore);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"这次星级为: %f",_HYBStarView.actualScore);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
