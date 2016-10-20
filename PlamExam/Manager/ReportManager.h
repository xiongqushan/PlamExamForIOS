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

//如果服务端没有取到体检报告，传入长度为0的空集合
- (void)saveUserInfo:(NSArray<ReportSimple*> *)reports ;

-(NSMutableArray<ReportSimple*>*)getReportList;

-(BOOL)exist;

-(void)clear;

@end
