//
//  TYCyclePagerViewCell.m
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/14.
//  Copyright © 2017年 tany. All rights reserved.
//

#import "TYCyclePagerViewCell.h"

@interface TYCyclePagerViewCell ()
@end

@implementation TYCyclePagerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addImage];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addImage];
    }
    return self;
}

- (void)addImage {
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBanner:)];
    [imageview addGestureRecognizer:tapImage];
    
    [self addSubview:imageview];
    _imageView = imageview;

}

- (void)tapBanner:(UITapGestureRecognizer*)tap{
    if (self.tapBannerBlock) {
        self.tapBannerBlock();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}

@end
