//
//  HZNavigationController.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZNavigationController.h"

@interface HZNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {//push进来的不是第一个控制器
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"navigationbar_pic_back_icon"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 30, 30);
        //设置按钮上图片的偏移量
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        //设置图片左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [button setImage:[UIImage imageNamed:@"navigationbar_pic_back_icon"] forState:UIControlStateNormal];
        //        [button sizeToFit];
        //        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //        UIView *containView = [[UIView alloc] initWithFrame:button.bounds];
        //        [containView addSubview:button];
        //        //containView.backgroundColor = [UIColor redColor];
        //        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:containView];
        
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //这句话要放在后面，让ViewController 可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];

}

- (void)back {
    [self popViewControllerAnimated:YES];
    
}

//滑动返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count == 1) {
        return NO;
    }else {
        return YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
