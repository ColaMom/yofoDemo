//
//  RHFCustomButton.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/4/24.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "RHFCustomButton.h"

#define scale 0.7
static const NSInteger DefaultFont = 17;

@interface RHFCustomButton ()

@property (nonatomic,strong)buttonHandler handler;

@end


@implementation RHFCustomButton


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.font = RRFont(DefaultFont);
        self.titleLabel.textColor = KDarkColor;
        self.buttonStyle = RHFCustomButtonImageLeft;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.titleLabel.font = RRFont(DefaultFont);
        self.titleLabel.textColor = KDarkColor;
        self.buttonStyle = RHFCustomButtonImageLeft;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)buttonAction:(UIButton *)sender{
    if (self.handler) {
        self.handler(sender);
    }
}



- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (self.buttonStyle == RHFCustomButtonImageRight) {
        return [self imageRectWithImageRightForContentTect:contentRect];
    }
    else if (self.buttonStyle == RHFCustomButtonImageTop){
        return [self imageRectWithImageTopForContentTect:contentRect];
    }
    else if (self.buttonStyle == RHFCustomButtonImageBottom){
        return [self imageRectWithImageBottomForContentTect:contentRect];
    }
    else {
        return [self imageRectWithImageLeftForContentTect:contentRect];
    }
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (self.buttonStyle == RHFCustomButtonImageRight) {
        return [self titleRectWithImageRightForContentTect:contentRect];
    }
    else if (self.buttonStyle == RHFCustomButtonImageTop){
        return [self titleRectWithImageTopForContentTect:contentRect];
    }
    else if (self.buttonStyle == RHFCustomButtonImageBottom){
        return [self titleRectWithImageBottomForContentTect:contentRect];
    }
    else {
        return [self titleRectWithImageLeftForContentTect:contentRect];
    }
}

#pragma mark imageLeft 图片在左 文字在右
- (CGRect)imageRectWithImageLeftForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat inteval = (CGRectGetHeight(contentRect)-imageWH)/2;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (imageX < 0) {
        imageX = 0;
    }
    CGRect rect = CGRectMake(imageX, inteval, imageWH, imageWH);
    
    return rect;
}

- (CGRect)titleRectWithImageLeftForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (imageX < 0) {
        imageX = 0;
    }
    CGRect rect = CGRectMake(imageWH+imageX, 0, titleW , CGRectGetHeight(contentRect));
    
    return rect;
}

#pragma mark imageRight 图片在右 文字在左
- (CGRect)imageRectWithImageRightForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat inteval = (CGRectGetHeight(contentRect)-imageWH)/2;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (titleX < 0) {
        titleX = 0;
    }
    CGRect rect = CGRectMake(titleX+titleW , inteval, imageWH, imageWH);
    
    return rect;
}

- (CGRect)titleRectWithImageRightForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (titleX < 0) {
        titleX = 0;
    }
    CGRect rect = CGRectMake(titleX, 0, titleW , CGRectGetHeight(contentRect));
    
    return rect;
}

#pragma mark imageTop 图片在上 文字在下
- (CGRect)imageRectWithImageTopForContentTect:(CGRect)contentRect{
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageWH = (CGRectGetHeight(contentRect)-titleH)*scale;
    CGFloat imageX = (CGRectGetWidth(contentRect) - imageWH)/2;
//    CGFloat imageY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2;
    CGFloat imageY = (CGRectGetHeight(contentRect) - titleH)*(1-scale)/3.0;
    CGRect rect = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    return rect;
}

- (CGRect)titleRectWithImageTopForContentTect:(CGRect)contentRect{
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
//    CGFloat imageWH = CGRectGetHeight(contentRect)/2;
    CGFloat imageWH = (CGRectGetHeight(contentRect)-titleH)*scale;
//    CGFloat titleY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2+imageWH+8;
    CGFloat titleY = (CGRectGetHeight(contentRect) - titleH)*(1-scale)/3.0*2 + imageWH;
    
    CGRect rect = CGRectMake(0, titleY, CGRectGetWidth(contentRect) , titleH);
    
    return rect;
}

#pragma mark imageBottom 图片在下 文字在上
- (CGRect)imageRectWithImageBottomForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2+titleH;
    CGFloat imageX = (CGRectGetWidth(contentRect) - imageWH)/2;
    CGRect rect = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    return rect;
}

- (CGRect)titleRectWithImageBottomForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2;
    CGRect rect = CGRectMake(0, titleY, CGRectGetWidth(contentRect) , titleH);
    
    return rect;
}


#pragma mark 计算标题内容宽度
- (CGFloat)widthForTitleString:(NSString *)string ContentRect:(CGRect)contentRect{
    if (string) {
        CGSize constraint = contentRect.size;
        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.titleLabel.font}];
        CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        CGFloat width = MAX(size.width, 30);
        CGFloat imageW = [self imageForState:UIControlStateNormal].size.width;
        
        if (width+imageW > CGRectGetWidth(contentRect)) { // 当标题和图片宽度超过按钮宽度时不能越界
            return  CGRectGetWidth(contentRect) - imageW;
        }
        return width+10;
    }
    else {
        return CGRectGetWidth(contentRect)/2;
    }
}

#pragma mark 计算标题文字内容的高度
- (CGFloat)heightForTitleString:(NSString *)string ContentRect:(CGRect)contentRect{
    if (string) {
        CGSize constraint = contentRect.size;
        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.titleLabel.font}];
        CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        CGFloat height = MAX(size.height, 5);
        
        if (height > CGRectGetHeight(contentRect)/2) { // 当标题高度超过按钮1/2宽度时
            return  CGRectGetHeight(contentRect)/2 ;
        }
        return height;
    }
    else {
        return CGRectGetHeight(contentRect)/2;
    }
}


@end
