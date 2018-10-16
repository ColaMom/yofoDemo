//
//  ECSearchField.m
//  ElecCarManager
//
//  Created by XXL on 16/8/26.
//  Copyright © 2016年 BBDTek. All rights reserved.
//

#import "RHFSearchField.h"

@implementation RHFSearchField

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.background = [UIImage imageWithColor:[@"F0F0F0" rgbColor]];
        self.layer.cornerRadius = frame.size.height/2.0;
//        self.layer.cornerRadius = 5;
        self.layer.borderColor = [@"f0f0f0" rgbColor].CGColor;
        self.layer.borderWidth = 1;
        self.layer.masksToBounds = YES;
        self.tintColor = [UIColor blackColor];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    //关闭首字母大写
    [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    //搜索图标
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRM(0, 0, 30, 14)];
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    leftImageView.image = [UIImage imageNamed:@"search"];
    self.leftView = leftImageView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel *)subView;
            label.textColor = [@"999999" rgbColor];
            label.font = RRFont(13.0);
            break;
        }
    }
}

@end
