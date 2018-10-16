//
//  TYCyclePagerViewCell.h
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/14.
//  Copyright © 2017年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYCyclePagerViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (copy, nonatomic) void(^tapBannerBlock)();
@end
