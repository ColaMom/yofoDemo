//
//  CLTagView.h
//  CLTageViewDemo
//
//  Created by Criss on 2017/4/25.
//  Copyright © 2017年 Criss. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RHFArticleTagSectionModel;
@class RHFArticleTagModel;
@protocol CLTagViewDeleagte <NSObject>
/**
 *回调当前分组内已选中的所有标签
 */
- (void)CLTagViewDidSelect:(NSMutableArray *)selectedTag atSection:(NSUInteger) section addTag:(RHFArticleTagModel*)addTag deleteTag:(NSString*)deleteTagVal;

@end

@interface CLTagView : UIView

@property (strong, nonatomic) RHFArticleTagSectionModel *tagSectionModel;

@property (weak, nonatomic) id<CLTagViewDeleagte> delegate;
// 当前处于第几分组
@property (assign, nonatomic) NSUInteger section;

@end
