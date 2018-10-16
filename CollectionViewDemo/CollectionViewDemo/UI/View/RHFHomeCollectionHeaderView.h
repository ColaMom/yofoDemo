//
//  RHFHomeCollectionHeaderView.h
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/4/19.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHFArticleTagSectionModel.h"
@class RHFProductModel;
@class RHFHomeModulesModel;
@protocol RHFHomeCollectionHeaderViewDelegate <NSObject>
- (void)selectBannerAtIndex:(NSInteger)index;
- (void)goToModule:(RHFHomeModulesModel*)modulesModel;
- (void)goToProductDetail:(RHFProductModel *)product;
- (void)goToJapanRank;
- (void)goToKoreaRank;
- (void)unLockSkinPackage;

- (void)tagHeadrViewDidSelectTagAtIndex:(NSInteger)index;
- (void)tagHeadrViewSortBtnPress;
@end

@interface RHFHomeCollectionHeaderView : UICollectionReusableView
- (void)refreshView;
@property (strong, nonatomic) NSMutableArray* bannerList;
@property (strong,nonatomic)NSMutableArray<RHFProductModel*> *productList;
@property (strong, nonatomic)NSMutableArray<RHFHomeModulesModel*>* modulesList;
@property (weak, nonatomic) id<RHFHomeCollectionHeaderViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray<RHFArticleTagModel*> *selectedTags;
@end
