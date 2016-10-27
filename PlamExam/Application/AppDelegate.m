//
//  AppDelegate.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/9.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "AppDelegate.h"
#import "HZTabBarController.h"
#import "LoginViewController.h"
#import "UIColor+Utils.h"
#import <YYModel.h>
#import "UserManager.h"
#import "CommonUtil.h"
#import "iflyMSC/IFlyMSC.h"
#import "JPUSHService.h"
#import <UMSocialCore/UMSocialCore.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#define kIflyAppId @"5800754f" //讯飞AppId
#define kJPushAppId @"750c95297adeffc03b5439cb"  //极光推送AppId
#define kChannelId @"App Stroe"
#define kUMSocialAppKey @"580afbb63eae254280002824" //友盟appKey

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    [NSThread sleepForTimeInterval:2.0];
    //配置控件外观
    [self setUpControlUI];
    
    /**************** 配置讯飞初始化 *******************/
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",kIflyAppId];
    [IFlySpeechUtility createUtility:initString];
    
    //配置极光推送
    [self setUpJPushWithOptions:launchOptions];
    
    //配置友盟分享
    [self setUpUMSocial];
    
    /**************** 初始化根视图 *******************/
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UIViewController *rootVc = [[HZTabBarController alloc] init];
    if (![[UserManager shareInstance] isLogin]) {
        rootVc = [[LoginViewController alloc] init];
    }
    
    self.window.rootViewController = rootVc;
    
    [self.window makeKeyAndVisible];
    

    return YES;
}

- (void)setUpControlUI {
    /**************** 控件外观设置 *******************/
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    NSDictionary *navBarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleTextAttributes];
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationBarColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor tabBarColor]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateNormal];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;  //取消tabBar的透明效果
    
}

//配置友盟分享
- (void)setUpUMSocial {
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appKey
    [[UMSocialManager defaultManager] setUmSocialAppkey:kUMSocialAppKey];
    
    //设置新浪微博的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"436196584" appSecret:@"e7e5b817ca06547ef20f3a9c5bd4f650" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //设置QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105708851" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    //设置QQ空间
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"1105708851" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    //设置微信
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx35e5655ba6776765" appSecret:@"a01938c93230a27b338cf5bece21adea" redirectURL:@"http://mobile.umeng.com/social"];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        
    }
    
    return result;
}

//配置极光推送
- (void) setUpJPushWithOptions:(NSDictionary *)launchOptions {
    
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else
#endif
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //可以添加自定义categories
            [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                              UIUserNotificationTypeSound |
                                                              UIUserNotificationTypeAlert)
                                                  categories:nil];
        }
//        else {
//            //categories 必须为nil
//            [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                              UIRemoteNotificationTypeSound |
//                                                              UIRemoteNotificationTypeAlert)
//                                                  categories:nil];
//        }
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    // init Push(2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil  )
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppId
                          channel:kChannelId
                 apsForProduction:NO
            advertisingIdentifier:nil];

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"__________UserInfo:%@",userInfo);
    NSDictionary *aps = userInfo[@"aps"];
    [CommonUtil showHUDWithTitle:aps[@"alert"]];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark -- iOS10程序在前台收到通知之后调用的方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSLog(@"_______1234");
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddBadgeKVOKey object:nil];
}
#pragma mark -- ios10程序在后台收到通知调用的方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
   // [[NSNotificationCenter defaultCenter] postNotificationName:kAddBadgeKVOKey object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kGoConsulationNote object:nil];
    self.isNotification = YES;
}
#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
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
