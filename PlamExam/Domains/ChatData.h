//
//  ChatData.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatData : NSObject

@property (nonatomic, copy) NSString *AccountId;
@property (nonatomic, copy) NSString *DoctorId;
@property (nonatomic, copy) NSString *Type;  //3.体检报告    1.普通文字
@property (nonatomic, copy) NSString *SourceType;  // 1.用户   2.健管师
@property (nonatomic, copy) NSString *AppendInfo;
@property (nonatomic, copy) NSString *Content;
@property (nonatomic, copy) NSString *Date;
@property(nonatomic,strong)NSString* DoctorHeaderImage;
@property (nonatomic, assign) CGFloat textCellHeight;
@property (nonatomic, assign) CGFloat reportCellHeight;

@end
