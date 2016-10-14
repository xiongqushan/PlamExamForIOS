//
//  SettingCell.m
//  Health
//
//  Created by 郭凯 on 16/5/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SettingCell.h"
#import "BaseSetting.h"
#import "UIColor+Utils.h"

@interface SettingCell ()

@property (nonatomic, strong)UIImageView *arrowView;
@property (nonatomic, strong)UILabel *labelView;
@property (nonatomic, strong)UISwitch *switchView;

@end

@implementation SettingCell

- (UISwitch *)switchView {
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        _switchView.userInteractionEnabled = NO;
    }
    return _switchView;
}

- (UIImageView *)arrowView {
    if (_arrowView == nil) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
        _arrowView = arrowView;
    }
    return _arrowView;
}

- (UILabel *)labelView {
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
    }
    
    return _labelView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.textColor = [UIColor textColor];
    return cell;
}

- (void)setItem:(SettingItem *)item {
    _item = item;
    
    [self setUpData];
    
    [self setUpRightView];
    
    if ([_item isKindOfClass:[LabelItem class]]) {
        LabelItem *labelItem = (LabelItem *)_item;
        self.labelView.text = labelItem.titleText;
        [self addSubview:self.labelView];
    }else {
        [self removeFromSuperview];
    }
}

- (void)setUpData {
    self.textLabel.text = _item.title;
   // self.textLabel.font = [UIFont systemFontOfSize:14];
    self.detailTextLabel.text = _item.subTitle;
    self.imageView.image = _item.titleImage;
    
}

- (void)setUpRightView {
    if ([_item isKindOfClass:[ArrowItem class]]) {//箭头
        self.accessoryView = self.arrowView;
    }else if ([_item isKindOfClass:[SwitchItem class]]) {
        self.accessoryView = self.switchView;
       // self.switchView.on = [HZUtils getNotificationStatus];
    }else {
        self.accessoryView = nil;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.labelView.frame = self.bounds;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
