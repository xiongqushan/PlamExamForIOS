//
//  User.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *accountId;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *departId;
@property (nonatomic, copy) NSString *departName;
@property (nonatomic, copy) NSString *OS;
@property (nonatomic, copy) NSString *lastUpdateDate;

@end
