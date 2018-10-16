//
//  RHFBannerCollectionCell.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/8/10.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "RHFBannerCollectionCell.h"

@interface RHFBannerCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;

@end

@implementation RHFBannerCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.bannerImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:KPlaceHolder_Cover options:SDWebImageAllowInvalidSSLCertificates];
    self.bannerImage.contentMode = self.imageContentMode;
}


@end
