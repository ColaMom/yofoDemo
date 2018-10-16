//
//  CLRecentTagView.m
//  CLTageViewDemo
//
//  Created by Criss on 2017/4/20.
//  Copyright © 2017年 Criss. All rights reserved.
//

#import "CLRecentTagView.h"
#import "CLTagView.h"
#import "CLTagButton.h"
#import "CLStyleConfig.h"
#import "RHFArticleTagSectionModel.h"

@interface CLRecentTagView () <CLTagViewDeleagte>

@property (nonatomic, weak) UIScrollView *scrollView;
///所有已选择的标签
@property (strong, nonatomic)NSMutableArray* allSelectedTags;
@end

@implementation CLRecentTagView

- (NSMutableArray *)allSelectedTags{
    if (!_allSelectedTags) {
        _allSelectedTags = [NSMutableArray array];
//        for (int i=0; i<self.tagSectionModels.count; i++) {
//            NSMutableArray *sectionArr = [NSMutableArray array];
//            [_allSelectedTags addObject:sectionArr];
//        }
    }
    return _allSelectedTags;
}

- (NSMutableArray*)allUserAddTags{
    if (!_allUserAddTags) {
        _allUserAddTags = [NSMutableArray array];
    }
    return _allUserAddTags;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self showUI];
    }
    return self;
}

- (void)showUI {
    self.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.alwaysBounceVertical = YES;
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)setTagSectionModels:(NSMutableArray<RHFArticleTagSectionModel *> *)tagSectionModels {
    _tagSectionModels = tagSectionModels;
    [self.allSelectedTags removeAllObjects];
    //分拣已选的标签
    for (int i=0; i<self.tagSectionModels.count; i++) {
        RHFArticleTagSectionModel *tagSectionModel = self.tagSectionModels[i];
            NSMutableArray *tagSectionArray = [NSMutableArray array];
        for (RHFArticleTagModel *tagModel in tagSectionModel.data) {
            if (tagModel.isSelected) {
                [tagSectionArray addObject:tagModel];
            }
        }
        [self.allSelectedTags addObject:tagSectionArray];
    }
    CLTagView *lastTagView;
    CLTagView *perTagView;
    
    //根据数据源中的分组数循环创建分组标签
    for (int i = 0; i < tagSectionModels.count; i ++) {
        CLTagView *tagView = [[CLTagView alloc] init];
        [self.scrollView addSubview:tagView];
        tagView.delegate = self;
        tagView.section = i;
        //给分组标签赋值
        tagView.tagSectionModel = tagSectionModels[i];
        tagView.frame = CGRectMake(0, !i?:(CGRectGetMaxY(perTagView.frame) + kCLDistance), 0, CGRectGetMaxY(tagSectionModels[i].tagBtnArray.lastObject.frame)+ kCLDistance + kCLHeadViewdHeight);
        tagView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
//        tagView.displayTags = self.displayTags;
    
        perTagView = tagView;
        if (i == tagSectionModels.count - 1) {
            lastTagView = tagView;
        }
    }
    //并获取最后一个分组的最大y坐标设置Scrollview的大小
    CGSize scrollContenSize = self.scrollView.contentSize;
    scrollContenSize.height = CGRectGetMaxY(lastTagView.frame);
    self.scrollView.contentSize = scrollContenSize;
}

/**
 *汇集所有分组的已选择标签数据,回调给使用者
 */
- (void)CLTagViewDidSelect:(NSMutableArray *)selectedTag atSection:(NSUInteger)section addTag:(RHFArticleTagModel *)newTag deleteTag:(NSString *)deleteTagVal{
    //如果用户新加了标签
    if (newTag) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"val == %@ and key == %@",newTag.val,newTag.key];
        NSArray *fetch = [self.allUserAddTags filteredArrayUsingPredicate:pre];
        if (fetch.count==0) {
            [self.allUserAddTags addObject:newTag];
        }
    }
    if (!IsEmptyValue(deleteTagVal)) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"val == %@ and key == %@",deleteTagVal,@"user_Define"];
        NSArray *fetch = [self.allUserAddTags filteredArrayUsingPredicate:pre];
        if (fetch.count >0) {
            RHFArticleTagModel *existTag = fetch[0];
            [self.allUserAddTags removeObject:existTag];
        }
    }
  
    self.allSelectedTags[section] = selectedTag;
    
    NSMutableArray *mixSelectedTags = [NSMutableArray array];
    for (NSMutableArray *sectionTags in self.allSelectedTags) {
        for (RHFArticleTagModel *tagModel in sectionTags) {
            [mixSelectedTags addObject:tagModel];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(CLRecentTagViewDidSelectTag:mixSelectedTags:userAddTags:)]) {
        [self.delegate CLRecentTagViewDidSelectTag:self.allSelectedTags mixSelectedTags:mixSelectedTags userAddTags:self.allUserAddTags];
    }
}


@end
