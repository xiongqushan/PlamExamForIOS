//
//  HZTabBarController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZTabBarController.h"
#import "HZNavigationController.h"
#import "HomeViewController.h"
#import "ConsultViewController.h"
#import "PersonalViewController.h"

@interface HZTabBarController ()

@end

@implementation HZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"home"] selectedImage:[[UIImage imageNamed:@"home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:@"首页"];
    
    ConsultViewController *consulat = [[ConsultViewController alloc] init];
    [self setUpOneChildViewController:consulat image:[UIImage imageNamed:@"consulat"] selectedImage:[[UIImage imageNamed:@"consulat_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:@"咨询"];
    
    PersonalViewController *personal = [[PersonalViewController alloc] init];
    [self setUpOneChildViewController:personal image:[UIImage imageNamed:@"mine"] selectedImage:[[UIImage imageNamed:@"mine_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:@"我的"];
    
    
}

- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    
    HZNavigationController *nav = [[HZNavigationController alloc] initWithRootViewController:vc];
    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectedImage];
    
    vc.title = title;
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
