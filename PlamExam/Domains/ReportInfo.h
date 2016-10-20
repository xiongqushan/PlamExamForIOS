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
@property(nonatomic,assign) BOOL IsCalc;
@property(nonatomic,strong) NSString *Unit;
@property(nonatomic,strong) NSString *TextRef;
@property(nonatomic,assign) BOOL IsAbandon;
@property(nonatomic,assign) NSInteger ResultTypeID;
@property(nonatomic,assign) NSInteger ResultFlagID;
@property(nonatomic,strong) NSString *LowValueRef;
@property(nonatomic,strong) NSString *HighValueRef;
@property(nonatomic,assign) NSInteger *ShowIndex;
@end

@interface CheckItem : NSObject
@property(nonatomic,strong) NSString *CheckItemName;
@property(nonatomic,strong) NSString *CheckItemCode;
@property(nonatomic,strong) NSString *DepartmentName;
@property(nonatomic,strong) NSString *SalePrice;
@property(nonatomic,assign) NSInteger CheckStateID;
@property(nonatomic,strong) NSString *CheckUserName;
@property(nonatomic,strong) NSMutableArray<CheckResult*> *CheckResults;
@end

//汇总
@interface GeneralSummary : NSObject
@property(nonatomic,strong) NSString *SummaryName;
@property(nonatomic,strong) NSString *SummaryCode;
@property(nonatomic,strong) NSString *SummaryDescription;
@property(nonatomic,strong) NSString *ReviewAdvice;
@property(nonatomic,assign) BOOL IsPrivacy;
@property(nonatomic,strong) NSString *SummaryMedicalExplanation;
@property(nonatomic,strong) NSString *SummaryReasonResult;
@property(nonatomic,strong) NSString *SummaryAdvice;
@end

//
@interface GeneralAdvice : NSObject
@property(nonatomic,strong) NSString *AdviceCode;
@property(nonatomic,strong) NSString *AdviceName;
@property(nonatomic,strong) NSString *AdviceDescription;
@property(nonatomic,strong) NSString *IsPrivacy;
@property(nonatomic,assign) NSInteger ShowIndex;
@property(nonatomic,strong) NSString *GeneralSummarys;
@end

@interface ReportInfo : NSObject
@property(nonatomic,strong) NSString *CustomerName;
@property(nonatomic,strong) NSString *CheckUnitName;
@property(nonatomic,strong) NSString *CheckUnitCode;
@property(nonatomic,strong) NSString *OrderName;
@property(nonatomic,strong) NSString *OrderCode;
@property(nonatomic,strong) NSString *Birthday;
@property(nonatomic,strong) NSString *RegDate;
@property(nonatomic,strong) NSString *ReportDate;
@property(nonatomic,strong) NSString *Age;
@property(nonatomic,strong) NSString *CommitUserName;
@property(nonatomic,strong) NSString *WorkNo;
@property(nonatomic,strong) NSArray<CheckItem*> *CheckItems;
@property(nonatomic,strong) NSArray<GeneralSummary*> *GeneralSummarys;
@property(nonatomic,strong) NSArray<GeneralAdvice*> *GeneralAdvices;
@end
