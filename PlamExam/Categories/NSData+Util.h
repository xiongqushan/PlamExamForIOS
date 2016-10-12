//
//  NSData+Util.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Util)
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
@end
