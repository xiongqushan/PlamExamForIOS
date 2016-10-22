//
//  SZCirculationImageView.h
//  SZCirculationImage
//
//  Created by 吴三忠 on 16/4/22.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PlaceOfTitleView){
    kPlaceTopOfView = 1,
    kPlaceBottomOfView
};

typedef NS_ENUM(NSInteger, SZTitleViewStatus){
    
    SZTitleViewBottomOnlyPageControl = 0,
    SZTitleViewBottomOnlyTitle,
    SZTitleViewBottomPageControlAndTitle,
    SZTitleViewBottomPageTitleAndControl,
    SZTitleViewTopOnlyTitle,
    SZTitleViewTopOnlyPageControl,
    SZTitleViewTopPageControlAndTitle,
    SZTitleViewTopPageTitleAndControl,
};

@protocol SZCirculationImageViewDelegate <NSObject>

- (void)circulationImageView:(UIView *)circulationImageView didSelectIndex:(NSInteger)index;

@end

@interface SZCirculationImageView : UIView

@property (nonatomic, assign) id<SZCirculationImageViewDelegate>delegate;

/**
 *  图片填充模式
 */
@property (nonatomic, assign) UIViewContentMode imageContentMode;

/**
 *  是否隐藏页面控件，默认为 NO
 */
@property (nonatomic, assign) BOOL hiddenTitleView;

/**
 *  页面控件位置，默认是底部显示pagecontrol
 */
@property (nonatomic, assign) SZTitleViewStatus titleViewStatus;

/**
 *  页面控件未选时颜色，默认为灰色
 */
@property (nonatomic, strong) UIColor *defaultPageColor;

/**
 *  页面控件选中时颜色，默认为红色
 */
@property (nonatomic, strong) UIColor *currentPageColor;

/**
 *  停顿时间, 默认 3s
 */
@property (nonatomic, assign) float pauseTime;

/**
 *  标题的对齐方式
 */
@property (nonatomic, assign) NSTextAlignment titleAlignment;

/**
 *  标题颜色
 */
@property (nonatomic, strong) UIColor *titleColor;


- (instancetype)initWithFrame:(CGRect)frame andImageSourcePathArray:(NSArray *)array andPlaceImage:(UIImage *)placeImage andTitles:(NSArray *)titles;
- (instancetype)initWithFrame:(CGRect)frame andImageSourcePathArray:(NSArray *)array;
- (instancetype)initWithFrame:(CGRect)frame andImageSourcePathArray:(NSArray *)array andTitles:(NSArray *)titles;
- (instancetype)initWithFrame:(CGRect)frame andImageSourcePathArray:(NSArray *)array andPlaceImage:(UIImage *)placeImage;

-(void)datasourceChangeNotify:(NSArray<NSString*>*)imageArr;
@end
