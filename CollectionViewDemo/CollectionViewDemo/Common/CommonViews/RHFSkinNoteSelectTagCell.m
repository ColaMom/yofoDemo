//
//  RHFSkinNoteSelectTagCell.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/4/8.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "RHFSkinNoteSelectTagCell.h"

@interface RHFSkinNoteSelectTagCell ()
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@end


@implementation RHFSkinNoteSelectTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setTagModel:(RHFArticleTagModel *)tagModel{
    _tagModel = tagModel;
    self.tagLabel.text = tagModel.val;
}

- (void)setIsHighlighted:(BOOL)isHighlighted{
    _isHighlighted = isHighlighted;
    if (isHighlighted) {
        self.backgroundColor = [UIColor whiteColor];
        self.tagLabel.textColor = KThemeColor;
        [self rounded:13 width:1 color:KThemeColor];
    }
    else{
        self.backgroundColor = [UIColor whiteColor];
        self.tagLabel.textColor = KLightTextColor;
        [self rounded:13 width:1 color:KBorderColor];
    }
}

@end
