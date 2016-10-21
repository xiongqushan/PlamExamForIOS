//
//  HZSliderView.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZSliderView.h"
#import "UIColor+Utils.h"

#define kItemWidth 80
#define kScreenSize [UIScreen mainScreen].bounds.size
#define kTabBarH 55

@interface HZSliderView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)NSArray *controllerArr;
@property (nonatomic, strong)UICollectionView *collectionView;
//
@property (nonatomic, strong)UIView *sliderView; //滑块

@property (nonatomic, strong) UISegmentedControl *segmentView;
@end

@implementation HZSliderView
{
    UILabel *_badgeLabel;
}

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr controllerNameArr:(NSArray *)nameArr {
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleArr = titleArr;
        self.controllerArr = nameArr;
        self.tabBarHeight = kTabBarH;
        // [self setUpTabBar];
        [self setUpSegmentBar];
        [self setUpCollectionView];
    }
    
    return self;
}

- (void)setImageArr:(NSArray *)imageArr {
    _imageArr = [NSArray array];
    _imageArr = imageArr;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
  //  [self setUpTabBar];
//    [self setUpSegmentBar];
//    [self setUpCollectionView];
}


- (void)setUpSegmentBar {
    self.tabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kTabBarH)];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:self.titleArr];
    seg.frame = CGRectMake(40, 8, self.tabBar.bounds.size.width - 80, 39);
    seg.tintColor = kSetRGBColor(85, 173, 244); //设置边框 字体颜色
    
    NSDictionary *dicSeltet = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName,nil];
    [seg setTitleTextAttributes:dicSeltet forState:UIControlStateSelected];
    
    NSDictionary *dicNormal = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName,nil];
    [seg setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
    
    [seg addTarget:self action:@selector(selectedItem:) forControlEvents:UIControlEventValueChanged];
    seg.selectedSegmentIndex = 0;
    self.segmentView = seg;
    [self.tabBar addSubview:seg];
    
    [self addSubview:self.tabBar];
    
}

- (void)selectedItem:(UISegmentedControl *)segment {
    NSInteger seletedIndex = segment.selectedSegmentIndex;
    NSLog(@"_______selected:%ld",seletedIndex);
   // [self segmentSelectedIndex:seletedIndex];
    [self changePageWithIndex:seletedIndex];
}



////创建滑动头部滑动视图
//- (void)setUpTabBar {
//    self.tabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, _tabBarHeight)];
//    //self.tabBar.backgroundColor = [UIColor grayColor];
//    UIImageView *bgImageView =[[UIImageView alloc] initWithFrame:self.tabBar.bounds];
//    bgImageView.image = [UIImage imageNamed:@"tabbarBk"];
//    [self.tabBar addSubview:bgImageView];
//    
//    NSInteger itemCount = self.titleArr.count;
//    //每个item之间的间距
//    CGFloat itemSpace = (kScreenSize.width - kItemWidth *itemCount)/(itemCount +1);
//    
//    //循环添加tabBar上的View
//    for (NSInteger index = 0; index < self.titleArr.count; index++) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(itemSpace*(index+1) + kItemWidth*index, 0, kItemWidth, _tabBarHeight)];
//        // view.backgroundColor = [UIColor redColor];
//        view.tag = 201 + index;
//        //view添加点击手势
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
//        [view addGestureRecognizer:tap];
//        
//        UILabel *titleLabel = nil;
//        if (self.imageArr.count) {
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kItemWidth/2 - 15, 2, 30, 30)];
//            imageView.image = [UIImage imageNamed:@"goodsNew"];
//            [view addSubview:imageView];
//            
//            titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _tabBarHeight - 32, kItemWidth, 30)];
//            titleLabel.text = self.titleArr[index];
//            
//            titleLabel.font = _titleFont;
//            titleLabel.textAlignment = NSTextAlignmentCenter;
//            [view addSubview:titleLabel];
//        }else {
//            titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, kItemWidth, 30)];
//            titleLabel.text = self.titleArr[index];
//            // label.backgroundColor = [UIColor yellowColor];
//            titleLabel.textColor = [UIColor grayColor];
//            titleLabel.font = _titleFont;
//            titleLabel.textAlignment = NSTextAlignmentCenter;
//            [view addSubview:titleLabel];
//        }
//        titleLabel.tag = 101 + index;
//        
//        //        if (index == 0) {
//        //            _badgeLabel = [self setBadgeViewWithFrame:CGRectMake(kItemWidth - 25, 3, 22, 15) title:self.badgeValue];
//        //            [titleLabel addSubview:_badgeLabel];
//        //        }
//        
//        [self.tabBar addSubview:view];
//    }
//    
//    //添加滑块
//    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(itemSpace + 10, _tabBarHeight -2, kItemWidth - 20, 2)];
//    self.sliderView.backgroundColor = [UIColor navigationBarColor];
//    [self.tabBar addSubview:self.sliderView];
//    
//    [self addSubview:self.tabBar];
//   // [self selectedIndex:0];
//}
//
//- (UILabel *)setBadgeViewWithFrame:(CGRect)frame title:(NSString *)number{
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    //[label sizeToFit];
//    label.text = number;
//    label.backgroundColor = [UIColor redColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor];
//    label.layer.masksToBounds = YES;
//    label.layer.cornerRadius = frame.size.height/2;
//    label.font = [UIFont systemFontOfSize:12];
//    // [label sizeToFit];
//    if(label.bounds.size.width < 15) {
//        CGRect frame = label.frame;
//        frame.size.width = 15;
//        label.frame = frame;
//    }
//    return label;
//}


//创建collectionView
- (void)setUpCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(kScreenSize.width, kScreenSize.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _tabBarHeight, kScreenSize.width, kScreenSize.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
}

//- (void)viewTap:(UIGestureRecognizer *)tap {
//    NSInteger index = tap.view.tag - 201;
//   // [self selectedIndex:index];
//    [self changePageWithIndex:index];
//}

- (void)changePageWithIndex:(NSInteger)index {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.collectionView.contentOffset = CGPointMake(kScreenSize.width * index, 0);
    }];
    
    if (self.scrollBlock) {
        self.scrollBlock(index);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSInteger index = scrollView.contentOffset.x / kScreenSize.width;
//   // [self selectedIndex:index];
//    
//    if (self.scrollBlock) {
//        self.scrollBlock(index);
//    }
    
    if (scrollView == self.collectionView) {
        NSInteger index = scrollView.contentOffset.x / kScreenSizeWidth;
        self.segmentView.selectedSegmentIndex = index;
    }
}

//- (void)selectedIndex:(NSInteger)index {
//    
//    NSArray *arr = [self.tabBar subviews];
//    for (UIView *view in arr) {
//        if ([view isKindOfClass:[UIImageView class]]) {
//            
//        }else {
//            for (UIView *view2 in [view subviews]) {
//                UILabel *lab = (UILabel *)view2;
//                
//                if ((lab.tag - 101)== index) {
//                    lab.textColor = [UIColor navigationBarColor];
//                }else {
//                    lab.textColor = [UIColor grayColor];
//                }
//                
//            }
//        }
//    }
//    
//    NSInteger itemCount = self.titleArr.count;
//    //每个item之间的间距
//    CGFloat itemSpace = (kScreenSize.width - kItemWidth *itemCount)/(itemCount +1);
//    
//    CGFloat x = index*(itemSpace + kItemWidth) + itemSpace;
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.sliderView.frame = CGRectMake(x + 10, _tabBarHeight -2, kItemWidth - 20, 2);
//    }];
//}

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
