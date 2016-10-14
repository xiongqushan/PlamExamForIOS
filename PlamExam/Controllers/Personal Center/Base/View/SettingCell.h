//
//  SettingCell.h
//  Health
//
//  Created by 郭凯 on 16/5/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingItem;

@interface SettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)SettingItem *item;

@end
