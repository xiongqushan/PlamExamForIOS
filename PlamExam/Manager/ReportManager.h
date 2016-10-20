//
//  ReportManager.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportSimple.h"
@interface ReportManager : NSObject

@property(nonatomic,strong)NSMutableArray<ReportSimple*> *reports;

+(ReportManager*)shareInstance;

-(void)setReportList:(NSArray<ReportSimple *> *)reports;

-(BOOL)exist;

-(void)clear;

@end
