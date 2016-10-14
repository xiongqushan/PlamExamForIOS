//
//  AppDelegate.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/9.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseModel.h"
#import "HZTabBarController.h"
#import "LoginViewController.h"
#import "UIColor+Utils.h"
#import <YYModel.h>
#import "UserManager.h"
#import "CommonUtil.h"
#import "TestModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)setUpControlUI {
    /**************** 控件外观设置 *******************/
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    NSDictionary *navBarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleTextAttributes];
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationBarColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor tabBarColor]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUpControlUI];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSDictionary *param = @{@"Mobile":@"18301718531"};
    NSDictionary *param2 = @{@"ID":@"1",@"Arrs":@[@"1",@"1",@"对方会卡死"]};
    
    [BaseModel requestTestData1:param2 resultBlock:^(HttpRequestResult<TestModel *> *httpResult) {
        if (httpResult.IsHttpSuccess) {
            if (httpResult.HttpResult.Code == 1) {
                //成功
                TestModel *model = httpResult.Data;
                NSLog(@"________%@",model);
            }else {
                //失败
                [CommonUtil showHUDWithTitle:httpResult.HttpResult.Message];
            }
        }else {
            [CommonUtil showHUDWithTitle:httpResult.HttpMessage];
        }
    }];
    
    UIViewController *rootVc = [[HZTabBarController alloc] init];
    if (![UserManager isLogin]) {
        rootVc = [[LoginViewController alloc] init];
    }
    self.window.rootViewController = rootVc;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
