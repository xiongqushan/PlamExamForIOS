//
//  HZSliderView.m
//  HZSliderView
//
//  Created by 郭凯 on 16/10/25.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZSliderView.h"
#import "UIColor+Utils.h"

#define kScreenSize [UIScreen mainScreen].bounds.size
#define kItemWidth 80
#define kTabBarH 40

@interface HZSliderView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)NSArray *controllerArr;
@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)UIView *tabBar;
@property (nonatomic, strong)UIView *sliderView; //滑块
@end

@implementation HZSliderView

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr controllerNameArr:(NSArray *)nameArr {
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleArr = titleArr;
        self.controllerArr = nameArr;
        //self.tabBarHeight = 40;
        [self setUpTabBar];
        [self setUpCollectionView];
    }
    
    return self;
}

//创建滑动头部滑动视图
- (void)setUpTabBar {
    self.tabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kTabBarH)];
    //self.tabBar.backgroundColor = [UIColor grayColor];
    UIImageView *bgImageView =[[UIImageView alloc] initWithFrame:self.tabBar.bounds];
    bgImageView.image = [UIImage imageNamed:@"tabbarBk"];
    [self.tabBar addSubview:bgImageView];
    
    NSInteger itemCount = self.titleArr.count;
    //每个item之间的间距
    CGFloat itemSpace = (kScreenSize.width - kItemWidth *itemCount)/(itemCount +1);
    
    //循环添加tabBar上的View
    for (NSInteger index = 0; index < self.titleArr.count; index++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(itemSpace*(index+1) + kItemWidth*index, 0, kItemWidth, kTabBarH)];
        // view.backgroundColor = [UIColor redColor];
        view.tag = 201 + index;
        //view添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
        [view addGestureRecognizer:tap];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, kItemWidth, 30)];
        titleLabel.text = self.titleArr[index];
        // label.backgroundColor = [UIColor yellowColor];
        titleLabel.textColor = [UIColor navigationBarColor];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:titleLabel];
        
        titleLabel.tag = 101 + index;
        
        [self.tabBar addSubview:view];
    }
    
    //添加滑块
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(itemSpace, kTabBarH -2, kItemWidth, 2)];
    self.sliderView.backgroundColor = [UIColor navigationBarColor];
    [self.tabBar addSubview:self.sliderView];
    
    [self addSubview:self.tabBar];
    [self selectedIndex:0];
}

//创建collectionView
- (void)setUpCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(kScreenSize.width, kScreenSize.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kTabBarH, kScreenSize.width, kScreenSize.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
}

// 移动滑块位置
- (void)selectedIndex:(NSInteger)index {
    NSArray *arr = [self.tabBar subviews];
    for (UIView *view in arr) {
        if ([view isKindOfClass:[UIImageView class]]) {
            
        }else {
            for (UIView *view2 in [view subviews]) {
                UILabel *lab = (UILabel *)view2;
                
                if ((lab.tag - 101)== index) {
                    lab.textColor = [UIColor navigationBarColor];
                }else {
                    lab.textColor = [UIColor grayColor];
                }
            }
        }
    }
    NSInteger itemCount = self.titleArr.count;
    //每个item之间的间距
    CGFloat itemSpace = (kScreenSize.width - kItemWidth *itemCount)/(itemCount +1);
    
    CGFloat x = index*(itemSpace + kItemWidth) + itemSpace;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.sliderView.frame = CGRectMake( x, kTabBarH -2, kItemWidth, 2);
    }];
}

//滑动collectionView 改变偏移量
- (void)changePageWithIndex:(NSInteger)index {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.collectionView.contentOffset = CGPointMake(kScreenSize.width * index, 0);
    }];
}

//点击item  需要改变滑块位置 和 改变collectionView的偏移量
- (void)viewTap:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag - 201;
    [self selectedIndex:index];
    [self changePageWithIndex:index];
}

//滑动collectionView 只要改变滑块位置就行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / kScreenSize.width;
    [self selectedIndex:index];
}

#pragma mark -- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *viewController = self.controllerArr[indexPath.item];
    // ViewController.view.frame = CGRectMake(0, 0, kScreenSize.width, self.bounds.size.height - kTabBarHeight);
    [cell.contentView addSubview:viewController.view];
    return cell;
    
}

@end
