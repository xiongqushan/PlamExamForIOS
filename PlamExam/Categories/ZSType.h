//
//  ZSType.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZSIntType : NSObject
@property(nonatomic,assign) NSInteger Value;
- (instancetype) initWithValue:(NSInteger)value;
@end

@interface ZSBooleanType : NSObject
@property(nonatomic,assign) BOOL Value;
@end
