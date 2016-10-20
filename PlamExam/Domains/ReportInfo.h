//
//  ReportInfo.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckResult : NSObject
@property(nonatomic,strong) NSString *CheckIndexName;
@property(nonatomic,strong) NSString *CheckIndexCode;
@property(nonatomic,strong) NSString *ResultValue;
@property(nonatomic,strong) NSString *AppendInfo;
@property(nonatomic,strong) NSString *IsCalc;
@property(nonatomic,strong) NSString *Unit;
@property(nonatomic,strong) NSString *TextRef;
@property(nonatomic,strong) NSString *IsAbandon;
@property(nonatomic,strong) NSString *ResultTypeID;
@property(nonatomic,strong) NSString *ResultFlagID;
@property(nonatomic,strong) NSString *LowValueRef;
@property(nonatomic,strong) NSString *HighValueRef;
@property(nonatomic,strong) NSString *ShowIndex;
@end

@interface CheckItem : NSObject
@property(nonatomic,strong) NSString *CheckItemName;
@property(nonatomic,strong) NSString *CheckItemCode;
@property(nonatomic,strong) NSString *DepartmentName;
@property(nonatomic,strong) NSString *SalePrice;
@property(nonatomic,strong) NSString *CheckStateID;
@property(nonatomic,strong) NSString *CheckUserName;
@property(nonatomic,strong) NSMutableArray<CheckResult*> *CheckResults;
@end

@interface GeneralSummary : NSObject
@property(nonatomic,strong) NSString *SummaryName;
@property(nonatomic,strong) NSString *SummaryCode;
@property(nonatomic,strong) NSString *SummaryDescription;
@property(nonatomic,strong) NSString *ReviewAdvice;
@property(nonatomic,strong) NSString *IsPrivacy;
@property(nonatomic,strong) NSString *SummaryMedicalExplanation;
@property(nonatomic,strong) NSString *SummaryReasonResult;
@property(nonatomic,strong) NSString *SummaryAdvice;
@end

@interface GeneralAdvice : NSObject
@property(nonatomic,strong) NSString *AdviceCode;
@property(nonatomic,strong) NSString *AdviceName;
@property(nonatomic,strong) NSString *AdviceDescription;
@property(nonatomic,strong) NSString *IsPrivacy;
@property(nonatomic,strong) NSString *ShowIndex;
@property(nonatomic,strong) NSString *GeneralSummarys;
@end

@interface ReportInfo : NSObject

@end
