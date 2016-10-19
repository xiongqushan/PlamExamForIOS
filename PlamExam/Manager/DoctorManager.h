//
//  DoctorManager.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Doctor.h"
@interface DoctorManager : NSObject

@property(nonatomic,assign)NSInteger currentDoctorId;

@property(nonatomic,strong)NSMutableArray<Doctor*> *doctors;

+(DoctorManager*)shareInstance;

-(void) clearDoctorId;

-(BOOL) existDoctorId;

-(NSArray<Doctor*>*)getDoctorList;

-(void)setDoctorList:(NSArray<Doctor*>*)doctorList;

-(BOOL)existDoctorList;

@end
