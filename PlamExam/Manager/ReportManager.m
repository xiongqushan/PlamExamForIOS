//
//  ReportManager.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportManager.h"
#import <YYModel.h>
#define kReportListKey @"ReportListKey"
@implementation ReportManager

static ReportManager *instance = nil;

+(ReportManager*)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

//如果服务端没有取到体检报告，传入长度为0的空集合
- (void)saveUserInfo:(NSArray<ReportSimple*> *)reports {
    if(reports==nil){
        return;
    }
    instance.reports=[NSMutableArray<ReportSimple*> array];
    for (ReportSimple *report in reports) {
        [instance.reports addObject:report];
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:instance.reports forKey:kReportListKey];
    [userDefaults synchronize];
}

-(NSMutableArray<ReportSimple*>*)getReportList{
    if(instance.reports==nil){
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * str = [userDefaults objectForKey:kReportListKey];
        [userDefaults synchronize];
        if (str) {
            instance.reports=[NSMutableArray<ReportSimple*> yy_modelWithJSON:str];
        }
    }
    return instance.reports;
}

-(BOOL)exist{
    return [self getReportList]!=nil;
}

-(void)clear{
    self.reports=nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kReportListKey];
    [userDefaults synchronize];
}

@end
