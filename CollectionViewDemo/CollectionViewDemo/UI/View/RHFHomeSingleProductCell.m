//
//  RHFHomeProductCell.m
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/4/23.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "RHFHomeSingleProductCell.h"
#import "RHFProductModel.h"

@interface RHFHomeSingleProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;

@end

@implementation RHFHomeSingleProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setProductModel:(RHFProductModel *)productModel{
    _productModel = productModel;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:productModel.image] placeholderImage:KPlaceHolder_Product];
    self.productNameLabel.text = productModel.china_name;
    
//    NSMutableString *percentStr = [NSMutableString stringWithFormat:@"肤质匹配度:%ld",(long)productModel.skin_percent/100];
//    [percentStr appendString:@"%"];
//    self.skinPercentLabel.text = percentStr;
    
}
@end
