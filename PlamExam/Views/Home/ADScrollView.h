//
//  ADScrollView.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollViewItemDelegate<NSObject>
@required
-(void)onItemClick:(NSInteger)index;
@end

@interface ADScrollView : UIScrollView

-(instancetype)initWithCustom:(CGRect)frame ImageNames:(NSArray*)imageNames TimeInterval:(double)interval;

- (void)hiddenPageControl;
@end
