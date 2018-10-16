//
//  RHFBannerView.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/8/10.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "RHFBannerView.h"

#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "TYCyclePagerViewCell.h"


@interface RHFBannerView () <TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
@property (nonatomic,strong) UIImageView * noBannerImageView;
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@end
@implementation RHFBannerView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addPagerView {
    if (self.pagerView) {
        [self.pagerView removeFromSuperview];
    }
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    // registerClass or registerNib
    [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self addSubview:pagerView];
    _pagerView = pagerView;
    _pagerView.frame = CGRectMake(0, 0, self.width, self.height);

}

- (void)addPageControl {
    if (self.pageControl) {
        [self.pageControl removeFromSuperview];
    }
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
    _pageControl.frame = CGRectMake(0, self.height - 26, self.width, 26);
    
    _pageControl.currentPageIndicatorTintColor = KThemeColor;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];

}


- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
   
    [self addPagerView];
    [self addPageControl];
    
    _pageControl.numberOfPages = dataSource.count>1 ? dataSource.count:0;
    [_pagerView reloadData];
    if (self.dataSource.count>0) {
        self.pagerView.hidden = NO;
        self.noBannerImageView.hidden = YES;
    }
    else{
        self.pagerView.hidden = YES;
        if (!self.noBannerImageView) {
            UIImageView *placeholderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            placeholderImageView.image = KPlaceHolder_Cover;
            self.noBannerImageView = placeholderImageView;
            [self addSubview:placeholderImageView];
        }
        self.noBannerImageView.hidden = NO;

    }
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.dataSource.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.dataSource[index]] placeholderImage:KPlaceHolder_Cover];
    cell.tapBannerBlock = ^{
        if ([self.delegate respondsToSelector:@selector(RHFBannerViewDidSelectItemAtIndex:)]) {
            [self.delegate RHFBannerViewDidSelectItemAtIndex:index];
        }
    };
    
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame), CGRectGetHeight(pageView.frame));
    layout.itemSpacing = 15;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
//    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}




@end
