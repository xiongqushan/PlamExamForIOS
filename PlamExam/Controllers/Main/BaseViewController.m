//
//  BaseViewController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BaseViewController.h"
#import "UIColor+Utils.h"
#import "ConsultDetailViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor viewBackgroundColor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goConsult:) name:kGoConsulationNote object:nil];
}

- (void)goConsult:(NSNotification *)note {
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    //健康咨询
    ConsultDetailViewController *consulation = [[ConsultDetailViewController alloc] init];
    
    [self.navigationController pushViewController:consulation animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
