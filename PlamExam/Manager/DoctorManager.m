//
//  DoctorManager.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "DoctorManager.h"

@implementation DoctorManager

static DoctorManager *instance = nil;

+(DoctorManager*)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.doctorList=[[NSMutableArray<Doctor*> alloc] init];
    });
    return instance;
}

-(NSInteger) getCurrentDoctorId{
    return instance.currentDoctorId;
}

-(void) setCurrentDoctorId:(NSInteger)doctorId{
    instance.currentDoctorId=doctorId;
}

-(void) clearDoctorId{
    instance.currentDoctorId=0;
}

-(BOOL) existDoctorId{
    return instance.currentDoctorId==0;
}

-(NSArray<Doctor*>*)getDoctorList{
    return instance.doctorList;
}

-(void)setDoctorList:(NSMutableArray<Doctor *> *)doctorList{
    [instance.doctorList removeAllObjects];
    for(Doctor* doctor in doctorList){
        [instance.doctorList addObject:doctor];
    }
}

-(BOOL)existDoctorList{
    return instance.doctorList==nil || [instance.doctorList count]==0;
}

@end
