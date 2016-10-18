//
//  Doctor.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctor : NSObject
@property(nonatomic,assign) NSInteger Id;
@property(nonatomic,strong) NSString *realName;
@property(nonatomic,strong) NSString *imageSrc;
@property(nonatomic,strong) NSString *speciality;
@end
