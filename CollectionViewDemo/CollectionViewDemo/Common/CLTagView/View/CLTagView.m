//
//  CLTagView.m
//  CLTageViewDemo
//
//  Created by Criss on 2017/4/25.
//  Copyright © 2017年 Criss. All rights reserved.
//

#import "CLTagView.h"
#import "CLStyleConfig.h"
#import "CLTagButton.h"
#import "RHFArticleTagSectionModel.h"
@interface CLTagView () <CLTagButtonDelegate>
//分组标题
@property (nonatomic, weak) UILabel *titleLabel;
@property (weak, nonatomic) UIView *tagsShowView;
@property (nonatomic, strong) NSMutableDictionary *tagsCache;
//已选中的标签
@property (strong, nonatomic)NSMutableArray * selectedTags;

@end

@implementation CLTagView

- (NSMutableArray *)selectedTags{
    if (!_selectedTags) {
        _selectedTags = [NSMutableArray array];
    }
    return _selectedTags;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _tagsCache = [NSMutableDictionary dictionary];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTagsStatus:) name:kCLTagViewTagDeleteNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTagsStatus:) name:kCLDisplayTagViewAddTagNotification object:kCLDisplayTagViewAddTagObject];

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kCLHeadViewdHeight)];
    [self addSubview:headView];
    headView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:[CLStyleConfig sharedConfig].sectionTitleFontSize];
    titleLabel.textColor = [CLStyleConfig sharedConfig].sectionTitleColor;
    [headView addSubview:titleLabel];
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[titleLabel]-0-|" options:0 metrics:@{@"left": @(kCLTagViewHorizontaGap)} views:NSDictionaryOfVariableBindings(titleLabel)]];
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[titleLabel(==height)]" options:0 metrics:@{@"height": @(kCLHeadViewdHeight)} views:NSDictionaryOfVariableBindings(titleLabel)]];
    
    UIView *tagsShowView = [[UIView alloc] init];
    tagsShowView.backgroundColor = headView.backgroundColor;
    self.tagsShowView = tagsShowView;
    [self addSubview:tagsShowView];
    tagsShowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tagsShowView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tagsShowView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headView]-0-[tagsShowView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView, tagsShowView)]];
    
}

/**
 *setter,加载数据
 */
- (void)setTagSectionModel:(RHFArticleTagSectionModel *)tagSectionModel{
    _tagSectionModel = tagSectionModel;
    self.titleLabel.text = tagSectionModel.name;
    
    NSMutableArray<CLTagButton *> *tagBtnArrayM = [NSMutableArray array];
    for (int i = 0; i < tagSectionModel.data.count; i++) {
        RHFArticleTagModel *tagModel = tagSectionModel.data[i];
        //创建tag按钮
        CLTagButton *preTagBtn;
        CLTagButton *currentTagBtn;
        preTagBtn = i ? tagBtnArrayM[i - 1] : nil;
        currentTagBtn = [CLTagButton initWithTagDesc:tagModel.val];
        currentTagBtn.tagSelected = tagModel.isSelected;
        //该tag按钮的内容
        currentTagBtn.tagModel = tagModel;
        [tagBtnArrayM addObject: (CLTagButton *)[self reloadTagViewPreTag:preTagBtn currentTagBtn:currentTagBtn]];
        tagSectionModel.tagBtnArray = tagBtnArrayM;
    }
    
    [self layoutTags:tagSectionModel.tagBtnArray];
}

- (UIView *)reloadTagViewPreTag:(UIView *)preTagBtn currentTagBtn:(UIView *)currentTagBtn {
    
    CGFloat preTaling = preTagBtn? CGRectGetMaxX(preTagBtn.frame) : 0;
    CGFloat preBottom = preTagBtn? CGRectGetMaxY(preTagBtn.frame) : 0;
    CGFloat preY = preTagBtn? preTagBtn.frame.origin.y : kCLDistance;
    
    if (preTaling + kCLTagViewHorizontaGap * 2 + currentTagBtn.bounds.size.width > [UIScreen mainScreen].bounds.size.width) {
        currentTagBtn.frame = CGRectMake(kCLTagViewHorizontaGap, preBottom + kCLTextFieldsVerticalGap, currentTagBtn.frame.size.width, currentTagBtn.frame.size.height);
    }else {
        currentTagBtn.frame = CGRectMake(preTaling + kCLTextFieldsHorizontalGap, preY, currentTagBtn.frame.size.width, currentTagBtn.frame.size.height);
    }
    return currentTagBtn;
}

/**
 *布局tagsModel中的按钮
 */
- (void)layoutTags:(NSArray<CLTagButton *> *)tags {
    for (CLTagButton *tagBtn in tags) {
        tagBtn.tagBtnDelegate = self;
        tagBtn.layer.cornerRadius = [CLStyleConfig sharedConfig].tagCornerRadius;
        [_tagsCache setObject:tagBtn forKey:tagBtn.titleLabel.text];
        [self.tagsShowView addSubview:tagBtn];
    }
}



/**
 *按钮点击事件
 */
- (void)recentTagButtonClick:(CLTagButton *)tagBtn {
    
    //TODO: 处理当前所有已选中的标签
    // ...
    // ...
    // ...
//    NSIndexPath *tagIndexPath = [NSIndexPath indexPathForRow:tagBtn.tagModel.tagIndexPath.row inSection:self.section];
//    tagBtn.tagModel.tagIndexPath = tagIndexPath;
//
//    if (tagBtn.tagSelected) {
//        [self.selectedTags addObject:tagBtn.tagModel];
//    }else{
//        [self.selectedTags removeObject:tagBtn.tagModel];
//    }
    NSMutableArray *selectedTagBtns = [NSMutableArray array];
    for (CLTagButton *tagBtn in self.tagSectionModel.tagBtnArray) {
        if (tagBtn.tagSelected) {
            [selectedTagBtns addObject:tagBtn.tagModel];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(CLTagViewDidSelect:atSection:addTag:deleteTag:)]) {
        [self.delegate CLTagViewDidSelect:selectedTagBtns atSection:self.section addTag:nil deleteTag:nil];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kCLRecentTagViewTagClickNotification object:nil userInfo:@{kCLRecentTagViewTagClickKey: tagBtn}];

}

#pragma mark - 通知
- (void)reloadTagsStatus:(NSNotification *)notification {
    //删除,有可能删的是新加的.
    if (notification.object == nil) {
        CLTagButton *tagBtn = notification.userInfo[kCLTagViewTagDeleteKey];
        CLTagButton *deleteTagBtn = [_tagsCache objectForKey:tagBtn.titleLabel.text];
        if (deleteTagBtn) {
            deleteTagBtn.tagSelected = NO;
        }
        
        NSMutableArray *selectedTagBtns = [NSMutableArray array];
        for (CLTagButton *tagBtn in self.tagSectionModel.tagBtnArray) {
            if (tagBtn.tagSelected) {
                [selectedTagBtns addObject:tagBtn.tagModel];
            }
        }
        if (!deleteTagBtn) {
            //删的是用户自己添加的,传过去标签val
            if (self.delegate && [self.delegate respondsToSelector:@selector(CLTagViewDidSelect:atSection:addTag:deleteTag:)]) {
                [self.delegate CLTagViewDidSelect:selectedTagBtns atSection:self.section addTag:nil deleteTag:tagBtn.titleLabel.text];
            }
        }
        else{
            //删的是服务器的
            if (self.delegate && [self.delegate respondsToSelector:@selector(CLTagViewDidSelect:atSection:addTag:deleteTag:)]) {
                [self.delegate CLTagViewDidSelect:selectedTagBtns atSection:self.section addTag:nil deleteTag:nil];
            }
        }
      
        return;
    }
    //添加
    if ([notification.object isKindOfClass:[NSString class]]) {
        NSString *obj = notification.object;
        if ([obj isEqualToString:kCLDisplayTagViewAddTagObject]) {
            NSString *key = notification.userInfo[kCLDisplayTagViewAddTagKey];//标签名字
            
//            CLTagButton *addTagBtn = [_tagsCache objectForKey:key];
            CLTagButton *addTagBtn = [CLTagButton initWithTagDesc:key];
            addTagBtn.tagModel = [[RHFArticleTagModel alloc] init];
            addTagBtn.tagModel.val = key;
            addTagBtn.tagModel.key = @"user_Define";
            
            addTagBtn.tagSelected = YES;
            
            NSMutableArray *selectedTagBtns = [NSMutableArray array];
            for (CLTagButton *tagBtn in self.tagSectionModel.tagBtnArray) {
                if (tagBtn.tagSelected) {
                    [selectedTagBtns addObject:tagBtn.tagModel];
                }
            }

            if (self.delegate && [self.delegate respondsToSelector:@selector(CLTagViewDidSelect:atSection:addTag:deleteTag:)]) {
                [self.delegate CLTagViewDidSelect:selectedTagBtns atSection:self.section addTag:addTagBtn.tagModel deleteTag:nil];
            }
        }
    }
}
@end



