//
//  CLTagButton.m
//  CLTageViewDemo
//
//  Created by Criss on 2017/4/21.
//  Copyright © 2017年 Criss. All rights reserved.
//

#import "CLTagButton.h"
#import "CLStyleConfig.h"

@implementation CLTagButton
{
    UIMenuController *_menuController;
}
#pragma mark - 上面显示选中标签和写标签的时候用

- (instancetype)initWithTextField:(UITextField *)textField {
    if (self = [super initWithFrame:textField.frame]) {
        [self initializeAttributeWithTextField:textField];
    }
    return self;
}
- (void)initializeAttributeWithTextField:(UITextField *)textField {
    [self setTitle:textField.text forState:UIControlStateNormal];
    
    [self setTitleColor:kCLTag_Normal_TextColor forState:UIControlStateNormal];
    [self setTitleColor:kCLTag_Selected_TextColor forState:UIControlStateSelected];
    
    [self attributeRadius:textField.layer.cornerRadius borderWidth:kCLDashesBorderWidth borderColor:kCLTag_Normal_BorderColor contentMode:UIViewContentModeCenter font:textField.font];
    [self addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tagBtnClick:(UIButton *)sender {
    self.selected = !self.isSelected;
    if (self.selected) {
        _menuController = [UIMenuController sharedMenuController];
        UIMenuItem *resetMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteItemClicked:)];
        [self becomeFirstResponder];
        [_menuController setMenuItems:[NSArray arrayWithObject:resetMenuItem]];
        [_menuController setTargetRect:self.bounds inView:self];
        [_menuController setMenuVisible:YES animated:YES];
    }
    if ([self.tagBtnDelegate respondsToSelector:@selector(tagButtonDidSelected:)]) {
        [self.tagBtnDelegate tagButtonDidSelected:self];
    }
}

#pragma mark - 正常标签
+ (instancetype)initWithTagDesc:(NSString *)tagStr {
    CLTagButton *tagBtn = [[CLTagButton alloc] init];
    [tagBtn setTitle:tagStr forState:UIControlStateNormal];
    [tagBtn setTitleColor:[CLStyleConfig sharedConfig].tagDefaultTextColor forState:UIControlStateNormal];
    tagBtn.titleLabel.font = [UIFont systemFontOfSize:[CLStyleConfig sharedConfig].tagTextFontSize];
    
    CGSize size = [tagStr sizeWithAttributes:@{NSFontAttributeName:tagBtn.titleLabel.font}];

    CGFloat height = size.height + kCLTextFieldGap;
    [tagBtn attributeRadius:[CLStyleConfig sharedConfig].tagCornerRadius
                borderWidth:[CLStyleConfig sharedConfig].tagBorderWidth
                borderColor:[CLStyleConfig sharedConfig].tagDefaultBorderColor
                contentMode:UIViewContentModeCenter
                       font:tagBtn.titleLabel.font];
    CGFloat width = size.width + height;
    tagBtn.frame = CGRectMake([CLStyleConfig sharedConfig].tagViewHorizontalMargin, [CLStyleConfig sharedConfig].tagVerticalSpace, width, height);
    [tagBtn addTarget:tagBtn action:@selector(recentTagClick:) forControlEvents:UIControlEventTouchUpInside];
    return tagBtn;
}

/**
 *设置按钮的样式,圆角,边框宽度,边框颜色,字体
 */
- (void)attributeRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor contentMode:(UIViewContentMode)contentMode font:(UIFont *)font{
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    self.titleLabel.contentMode = contentMode;
    self.titleLabel.font = font;
}

/**
 *重写方法 setSelected:
 */
- (void)setSelected:(BOOL)selected {
    //只对上面显示的选中的按钮有效
    [super setSelected:selected];
    if (self.isSelected) {
        self.backgroundColor = [CLStyleConfig sharedConfig].tagSelectedBackgroundColor;
        [self setTitleColor:[CLStyleConfig sharedConfig].tagSelectedTextColor forState:UIControlStateNormal];
        self.layer.borderColor = [CLStyleConfig sharedConfig].tagSelectedBorderColor.CGColor;
    }else {
        self.backgroundColor = [CLStyleConfig sharedConfig].tagSelectedBackgroundColor;
        [self setTitleColor:[CLStyleConfig sharedConfig].tagSelectedTextColor forState:UIControlStateNormal];
        self.layer.borderColor = [CLStyleConfig sharedConfig].tagSelectedBorderColor.CGColor;
        if (_isNotSelf) {
            _isNotSelf = NO;
            return;
        }
        !_menuController?:[_menuController setMenuVisible:NO animated:YES];
    }
}


/**
 *设置按钮 选中和未选中的样式
 */
- (void)setTagSelected:(BOOL)tagSelected {
    _tagSelected = tagSelected;
    self.tagModel.isSelected = tagSelected;
    
    if (self.tagSelected) {
        self.backgroundColor = [CLStyleConfig sharedConfig].tagSelectedBackgroundColor;
        [self setTitleColor:[CLStyleConfig sharedConfig].tagSelectedTextColor forState:UIControlStateNormal];
        self.layer.borderColor = [CLStyleConfig sharedConfig].tagSelectedBorderColor.CGColor;
    }else {
        self.backgroundColor = [CLStyleConfig sharedConfig].tagDefaultBackgroundColor;
        [self setTitleColor:[CLStyleConfig sharedConfig].tagDefaultTextColor forState:UIControlStateNormal];
        self.layer.borderColor = [CLStyleConfig sharedConfig].tagDefaultBorderColor.CGColor;
    }
}

/**
 *按钮点击的事件
 */
- (void)recentTagClick:(UIButton *)sender {
    //点击时,更改按钮样式
    self.tagSelected = !self.tagSelected;
   
    if ([self.tagBtnDelegate respondsToSelector:@selector(recentTagButtonClick:)]) {
        [self.tagBtnDelegate recentTagButtonClick:self];
    }
}

/**
 * 删除选中标签
 */
- (void)deleteItemClicked:(id)sender {
    self.selected = NO;
    if ([self.tagBtnDelegate respondsToSelector:@selector(tagButtonDelete:)]) {
        [self.tagBtnDelegate tagButtonDelete:self];
    }
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
@end
