//
//  RHFUserSkinNoteStyleCell.m
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/3/3.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "RHFUserSkinNoteStyleCell.h"
#import "RHFPaddingLabel.h"

@interface RHFUserSkinNoteStyleCell()
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *authorAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIView *whiteContentView;
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *coverImgae;

@property (weak, nonatomic) IBOutlet UIImageView *imageTypeIcon;
@property (weak, nonatomic) IBOutlet RHFPaddingLabel *skinLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userVImageView;

@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@end

@implementation RHFUserSkinNoteStyleCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.skinLabel.edgeInsets = kSkintypeEdgeInsets;
    [self.skinLabel rounded:7.5];
    self.skinLabel.backgroundColor = KSkinTypeColor;
}

-(void)setArticleModel:(RHFArticleModel *)articleModel{
    _articleModel = articleModel;
    [self.coverImgae rounded:10];
    self.skinLabel.text = IsEmptyValue(articleModel.skinType)?@"暂无":articleModel.skinType;
    self.zanBtn.selected = articleModel.isPraise;
    self.articleTitleLabel.text = articleModel.title;
    
    self.coverImgae.yy_imageURL = [NSURL URLWithString:articleModel.articleImage];
    
    self.authorNameLabel.text = articleModel.nickname;
    
    if (!IsEmptyValue(articleModel.userImage)) {
        [self.authorAvatarImageView yy_setImageWithURL:[NSURL URLWithString:articleModel.userImage] placeholder:KPlaceHolder_Avatar];
    }
    else if (!IsEmptyValue(articleModel.image)){
        [self.authorAvatarImageView yy_setImageWithURL:[NSURL URLWithString:articleModel.image] placeholder:KPlaceHolder_Avatar];
    }
    else{
        self.authorAvatarImageView.image = KPlaceHolder_Avatar;
    }
    [self.authorAvatarImageView rounded:15];
    self.likeCountLabel.text = articleModel.praise;
    self.userVImageView.hidden = !articleModel.v.boolValue;
    if (articleModel.is_gif.boolValue) {
        self.imageTypeIcon.hidden = NO;
        self.imageTypeIcon.image = [UIImage imageNamed:@"gifIcon"];
    }
    else if (!IsEmptyValue(articleModel.video)){
        self.imageTypeIcon.hidden = NO;
        self.imageTypeIcon.image = [UIImage imageNamed:@"videoIcon"];
    }
    else{
        self.imageTypeIcon.hidden = YES;
    }
}

- (IBAction)zanAction:(id)sender {
    if (self.praiseArticleBlock) {
        self.praiseArticleBlock(self.articleModel);
    }
}
@end
