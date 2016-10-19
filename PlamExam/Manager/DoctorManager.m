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

-(void) clearDoctorId{
    self.currentDoctorId=0;
}

-(BOOL) existDoctorId{
    return self.currentDoctorId>0;
}

-(NSArray<Doctor*>*)getDoctorList{
    return self.doctors;
}

-(void)setDoctorList:(NSMutableArray<Doctor *> *)doctorList{
    [self.doctors removeAllObjects];
    for(Doctor* doctor in doctorList){
        [self.doctors addObject:doctor];
    }
}

-(BOOL)existDoctorList{
    return self.doctors!=nil && [self.doctors count]>0;
}

-(Doctor*)getCurrentDoctor{
    if([self existDoctorId] && [self existDoctorList]){
        for (Doctor *doctor in self.doctors) {
            if(doctor.Id==self.currentDoctorId){
                return doctor;
            }
        }
    }
    return nil;
}

-(Doctor*)getDoctor:(NSInteger)doctorId{
    if([self existDoctorList]){
        for (Doctor *doctor in self.doctors) {
            if(doctor.Id==doctorId){
                return doctor;
            }
        }
    }
    return nil;
}
@end
