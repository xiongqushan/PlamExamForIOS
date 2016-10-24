//
//  SystemSettingModel.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSType.h"
@interface SystemSettingModel : NSObject
//意见反馈
+ (void)sendFeedbackDepartName:(NSString *)departName realName:(NSString *)realName mobile:(NSString *)mobile feedbackContent:(NSString *)content callBack:(void(^)(HttpRequestResult<ZSBoolType *>*httpResult))callBack;

@end
