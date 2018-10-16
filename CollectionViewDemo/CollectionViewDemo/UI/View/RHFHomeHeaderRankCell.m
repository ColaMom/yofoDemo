//
//  RHFHomeHeaderRankCell.m
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/4/19.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "RHFHomeHeaderRankCell.h"

@interface RHFHomeHeaderRankCell ()
@property (weak, nonatomic) IBOutlet UIButton *japanBtn;
@property (weak, nonatomic) IBOutlet UIButton *koreaBtn;

@end

@implementation RHFHomeHeaderRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)goToJapan:(id)sender {
    if ([self.delegate respondsToSelector:@selector(goToJapanRank)]) {
        [self.delegate goToJapanRank];
    }
}
- (IBAction)goToKorea:(id)sender {
    if ([self.delegate respondsToSelector:@selector(goToKoreaRank)]) {
        [self.delegate goToKoreaRank];
    }
}

@end
