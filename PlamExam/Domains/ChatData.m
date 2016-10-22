//
//  ChatData.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ChatData.h"
#import "CommonUtil.h"

@implementation ChatData
{
    CGFloat _cellHeight;
}

- (CGFloat)textCellHeight {
    if (!_cellHeight) {
        NSString *content = self.Content;
        
        CGFloat height = [CommonUtil getHeightWithFont:[UIFont systemFontOfSize:15] title:content maxWidth:kScreenSizeWidth - 166];
        _cellHeight = height + 62;
    }
    return _cellHeight;
}
@end
