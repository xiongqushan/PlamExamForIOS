//
//  NewsSimple.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsSimple : NSObject
@property(nonatomic,assign)NSInteger Id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *timeFormat;
@property(nonatomic,strong)NSString *descriptions;
@property(nonatomic,strong)NSString *imgFormat;
@end
