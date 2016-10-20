//
//  ReportBatch.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportSimple.h"
@interface ReportBatch : NSObject
@property(nonatomic,strong)NSString *CheckUnitCode;
@property(nonatomic,strong)NSString *DepartName;
@property(nonatomic,strong)NSArray<ReportSimple*> *Reports;
@end
