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

-(void)setReportList:(NSArray<ReportSimple *> *)reports{
    if(reports==nil){
        return;
    }
    instance.reports=[NSMutableArray<ReportSimple*> array];
    NSMutableArray<NSString*>*localArr=[[NSMutableArray<NSString*> alloc] init];
    for (ReportSimple *report in reports) {
        [instance.reports addObject:report];
        NSString *localStr=[report yy_modelToJSONString];
        [localArr addObject:localStr];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:localArr forKey:kReportListKey];
    [userDefaults synchronize];
}

-(NSMutableArray<ReportSimple *> *)getReportList{
    if(instance.reports==nil){
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray<NSString*>* localArr = [userDefaults objectForKey:kReportListKey];
        [userDefaults synchronize];
        if (localArr) {
            instance.reports=[[NSMutableArray<ReportSimple*> alloc] init];
            for(NSString* localStr in localArr){
                ReportSimple *reportSimple=[ReportSimple yy_modelWithJSON:localStr];
                [instance.reports addObject:reportSimple];
            }
        }
    }
    return instance.reports;
}

-(BOOL)exist{
    [self getReportList];
    BOOL exist=self.reports!=nil;
    return exist;
}

-(void)clear{
    self.reports=nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kReportListKey];
    [userDefaults synchronize];
}

@end
