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
@property (nonatomic, copy) NSString *Type;
@property (nonatomic, copy) NSString *SourceType;
@property (nonatomic, copy) NSString *AppendInfo;
@property (nonatomic, copy) NSString *Content;
@property (nonatomic, copy) NSString *Date;

@end
