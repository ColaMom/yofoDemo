//
//  BaseCell.m
//  BBDTek
//
//  Created by  ZhuHong on 16/7/12.
//  Copyright © 2016年 BBDTek. All rights reserved.
//

#import "BaseCell.h"

@interface BaseCell ()

@property (nonatomic, weak) UIView* lineView;

@end

@implementation BaseCell



/** 快速获取cell */
+ (instancetype)cell:(UITableView*)tableView {
    NSString* ID = NSStringFromClass(self);
    BaseCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        [tableView registerClass:self forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    
    return cell;
}

/** 快速获取cell */
+ (instancetype)xibCell:(UITableView*)tableView {
    NSString* ID = NSStringFromClass(self);
    BaseCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    
    return cell;
}

/** 返回一个空白的cell */
+ (id)blankCell:(UITableView*)tableView {
    static NSString* const ID = @"EMMBlanckCellID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    return cell;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
//    [self setup];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
//    [self setup];
    
    return self;
}

/*
- (void)setup {
    self.imageView.contentMode = UIViewContentModeCenter;
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    UIView* lineView = [[UIView alloc] init];
    lineView.hidden = YES;
    lineView.backgroundColor = [@"ebebeb" rgbColor];
    self.lineView = lineView;
    [self.contentView addSubview:lineView];
    
//    self.backgroundColor = ECBGColor;
//    self.contentView.backgroundColor = ECBGColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setHiddenLineView:(BOOL)hiddenLineView {
    _hiddenLineView = hiddenLineView;
    self.lineView.hidden = hiddenLineView;
}

- (void)setLineInsets:(UIEdgeInsets)lineInsets {
    _lineInsets = lineInsets;
    self.lineView.hidden = NO;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lineView.frame = ECCGM(0, self.height-1.0, self.width, 1.0);
    CGFloat x;
    CGFloat width;
    CGFloat height = 1;
    CGFloat y = self.height-height;
 
    if (self.lineInsets.left > 0 ||self.lineInsets.right > 0) {
 
        x = _lineInsets.left;
        width = self.contentView.width - _lineInsets.left - _lineInsets.right;
 
    }else {
 
        x = 0;
        width = self.width;
    }
 
    self.lineView.frame = CGRM(x, y, width, height);
}
 
*/


@end
