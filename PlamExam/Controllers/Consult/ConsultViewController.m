//
//  ConsultViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ConsultViewController.h"
#import "GFWaterView.h"
#import "ConsultDetailViewController.h"

@interface ConsultViewController ()

@end

@implementation ConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSomeUI];
}

- (void)setUpSomeUI {
    UIButton *consultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    consultBtn.frame = CGRectMake((kScreenSizeWidth - 122)/2, 150 + 64, 122, 122);
    [consultBtn setImage:[UIImage imageNamed:@"consult_btn"] forState:UIControlStateNormal];
    [consultBtn addTarget:self action:@selector(goConsult:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:consultBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenSizeHeight - 129 - 46, kScreenSizeWidth, 50)];
    titleLabel.text = @"1位健康管理师将为您提供健康咨询\n点击上方按钮进入咨询";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = kSetRGBColor(51, 51, 51);
    [self.view addSubview:titleLabel];
    
   // [self performSelector:@selector(changeView) withObject:self afterDelay:3];
}

//- (void)changeView {
//    ConsultDetailViewController *consult = [[ConsultDetailViewController alloc] init];
//    
//    [self.navigationController pushViewController:consult animated:YES];
//}

- (void)goConsult:(UIButton *)btn {
    
    ConsultDetailViewController *consult = [[ConsultDetailViewController alloc] init];
    
    [self.navigationController pushViewController:consult animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
