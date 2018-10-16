//
//  CLRecentTagView.h
//  CLTageViewDemo
//
//  Created by Criss on 2017/4/20.
//  Copyright © 2017年 Criss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHFArticleTagSectionModel.h"

@protocol CLRecentTagViewDelegate <NSObject>

/**
 *回调已选中的所有分组标签
 */
- (void)CLRecentTagViewDidSelectTag:(NSMutableArray<NSMutableArray *> *)selectedTag  mixSelectedTags:(NSMutableArray<RHFArticleTagSectionModel *> *)mixSelectedTags userAddTags:(NSMutableArray<RHFArticleTagModel*>*)userAddTags;

@end

@interface CLRecentTagView : UIView

/**
 要展示的标签数据
 */
@property (strong, nonatomic) NSMutableArray<RHFArticleTagSectionModel *> *tagSectionModels;

@property (weak, nonatomic) id<CLRecentTagViewDelegate> delegate;
@property (nonatomic,strong) NSMutableArray<RHFArticleTagModel *> *allUserAddTags;


@end
