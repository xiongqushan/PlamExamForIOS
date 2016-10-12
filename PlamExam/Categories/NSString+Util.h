//
//  NSString+Util.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)
- (NSString *)base64EncodedString;

//把字符串加密成32位小写md5字符串
- (NSString*)md532BitLower;

//把字符串加密成32位大写md5字符串
- (NSString*)md532BitUpper;

@end
