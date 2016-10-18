//
//  ADScrollView.m
//  PlamExam
//
//  Created by 郭凯 on 16/10/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ADScrollView.h"
#import "NSTimer+Addition.h"
#import <UIImageView+WebCache.h>

@interface ADScrollView() <UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *totalImages;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, assign)NSInteger curpage;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)NSMutableArray *showImages;

@end

@implementation ADScrollView
{
    UIImageView *_imageView;
}
static double timerInterval;
-(instancetype)initWithCustom:(CGRect)frame ImageNames:(NSArray*)imageViews TimeInterval:(double)interval isNetWork:(BOOL)isNetwork{
    if (self=[super initWithFrame:frame]) {
        self.scrollView=[[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        self.scrollView.showsHorizontalScrollIndicator=NO;
        self.scrollView.showsVerticalScrollIndicator=NO;
        self.scrollView.pagingEnabled=YES;
        self.scrollView.contentSize=CGSizeMake(imageViews.count*frame.size.width, frame.size.height);
        self.scrollView.contentOffset=CGPointMake(0, 0);
        self.scrollView.delegate=self;
        self.totalImages=[[NSMutableArray alloc] init];
        for(int i=0;i<imageViews.count;i++){
            UIImageView *imageView = [[UIImageView alloc] init];
            if (isNetwork) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageViews[i]] placeholderImage:nil];
            }else {
                imageView = [imageViews objectAtIndex:i];
            }
            
            
            //imageView.contentMode=UIViewContentModeScaleAspectFit;
            [self.totalImages addObject:imageView];
        }
        
        self.pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(kScreenSizeWidth-60, self.scrollView.frame.size.height-20,60, 20)];
        //self.pageControl.backgroundColor=[ColorHelper ConvertFromRGB:@"cccccc" Alpha:0.4f];
        self.pageControl.numberOfPages=imageViews.count;
        self.curpage=0;
        //        self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
        //        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        [self rePlay:FALSE];
        
        timerInterval=interval;
        self.timer=[NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:TRUE];
    }
    return self;
}

- (void)hiddenPageControl {
    self.pageControl.hidden = YES;
}
-(void)reSetData{
    short int preIndex=self.curpage-1;
    short int nextIndex=self.curpage+1;
    
    if(self.curpage<0){
        self.curpage=self.totalImages.count-1;
        preIndex=self.curpage-1;
        nextIndex=0;
    }
    else if (self.curpage==0) {
        self.curpage=0;
        preIndex=self.totalImages.count-1;
        nextIndex=self.curpage+1;
    }
    else if(self.curpage==self.totalImages.count-1){
        self.curpage=self.totalImages.count-1;
        preIndex=self.curpage-1;
        nextIndex=0;
    }
    else if(self.curpage>self.totalImages.count-1){
        self.curpage=0;
        preIndex=self.totalImages.count-1;
        nextIndex=self.curpage+1;
    }
    if(!self.showImages){
        self.showImages=[[NSMutableArray alloc] init];
    }
    [self.showImages removeAllObjects];
    [self.showImages addObject:[self.totalImages objectAtIndex:preIndex]];
    [self.showImages addObject:[self.totalImages objectAtIndex:self.curpage]];
    [self.showImages addObject:[self.totalImages objectAtIndex:nextIndex]];
}

-(void)reBindImages:(BOOL)isAnimate{
    if (self.scrollView.subviews.count>0) {
        [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    for(int i=0;i<self.showImages.count;i++){
        UIImageView *imageView=[self.showImages objectAtIndex:i];
        imageView.frame=CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:imageView];
    }
    if (isAnimate) {//为了让自动切换时候产生动画效果，先重置偏移量
        [self.scrollView setContentOffset:CGPointMake(1, 0) animated:FALSE];
    }
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:isAnimate];
    self.pageControl.currentPage=self.curpage;
    
}

-(void)rePlay:(BOOL)isAnimate{
    [self reSetData];
    [self reBindImages:isAnimate];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer pauseTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.timer resumeTimerAfterTimeInterval:timerInterval];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(self.scrollView.contentOffset.x >= 2 * scrollView.frame.size.width) {
        self.curpage=self.curpage+1;
        [self rePlay:FALSE];
    }
    else if(self.scrollView.contentOffset.x <= 0) {
        self.curpage=self.curpage-1;
        [self rePlay:FALSE];
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

- (void)timerFireMethod:(NSTimer*)timer{
    self.curpage=self.curpage+1;
    [self rePlay:YES];
}

@end
