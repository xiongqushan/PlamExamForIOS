//
//  GroupItem.h
//  Health
//
//  Created by 郭凯 on 16/5/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupItem : NSObject

@property (nonatomic, strong)NSArray *items;
@property (nonatomic, copy)NSString *headerTitle;
@property (nonatomic, copy)NSString *footerTitle;

//@property (nonatomic, assign)BOOL isIntro;

@end
