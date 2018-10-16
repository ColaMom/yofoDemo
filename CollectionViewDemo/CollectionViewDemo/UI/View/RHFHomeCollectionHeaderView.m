//
//  RHFHomeCollectionHeaderView.m
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/4/19.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "RHFHomeCollectionHeaderView.h"

#import "RHFBannerView.h"
#import "RHFHomeHeaderCell1.h"
#import "RHFHomeHeaderSkinCell.h"
#import "RHFHomeHeaderRankCell.h"
#import "RHFSkinNoteSelectTagCell.h"
#import "RHFHomeModulesModel.h"

@interface RHFHomeCollectionHeaderView ()<RHFBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,RHFHomeHeaderCell1Delegate,RHFHomeHeaderSkinCellDelegate,RHFHomeHeaderRankCellDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet RHFBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *tagCollectionView;

@end

@implementation RHFHomeCollectionHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.tagCollectionView registerNib:[UINib nibWithNibName:@"RHFSkinNoteSelectTagCell" bundle:nil] forCellWithReuseIdentifier:@"RHFSkinNoteSelectTagCell"];
    self.tagCollectionView.delegate = self;
    self.tagCollectionView.dataSource = self;
}
- (void)refreshView{
    [self setupBanner];

    [self.tableView reloadData];
    [self.tagCollectionView reloadData];
}
- (void)setupBanner{
    
    self.bannerView.frame = CGRM(0, 0, self.width, 200);
    self.bannerView.contentMode = UIViewContentModeScaleToFill;
    self.bannerView.delegate = self;
    NSMutableArray *bannerImageList = [NSMutableArray array];
    for (RHFHomeModulesModel *bannerModel in self.bannerList) {
        [bannerImageList addObject:bannerModel.image];
    }
    self.bannerView.dataSource = bannerImageList;
    
}

#pragma mark - 轮播图的点击<RHFBannerViewDelegate>
- (void)RHFBannerViewDidSelectItemAtIndex:(NSInteger )index{
    if ([self.delegate respondsToSelector:@selector(selectBannerAtIndex:)]) {
        [self.delegate selectBannerAtIndex:index];
    }
}

#pragma mark - <UITableViewDelegate>

/**
 有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//每组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 115;
    }
    else if (indexPath.row == 1){
        return 240;
    }
    if (indexPath.row == 2){
        //排行榜
        return 90*(KScreenWidth/375);
    }
    return 0;
}

//每行的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //测肤,试用,话题等模块
        RHFHomeHeaderCell1 *cell = [RHFHomeHeaderCell1 xibCell:tableView ];
        cell.modulesList = self.modulesList;
        cell.delegate = self;
        return cell;
    }
    else if (indexPath.row == 1){
        //肤质
        RHFHomeHeaderSkinCell *cell = [RHFHomeHeaderSkinCell xibCell:tableView];
        cell.dataSource = self.productList;
        cell.delegate = self;
        return cell;

    }
    else if (indexPath.row == 2){
        RHFHomeHeaderRankCell *cell = [RHFHomeHeaderRankCell xibCell:tableView];
        cell.delegate = self;
        return cell;

    }
    return nil;
}

#pragma mark - RHFHomeHeaderCell1Delegate

- (void)goToModule:(RHFHomeModulesModel*)modulesModel{

    if ([self.delegate respondsToSelector:@selector(goToModule:)]) {
        [self.delegate goToModule:modulesModel];
    }
}
#pragma mark - RHFHomeHeaderSkinCellDelegate
- (void)goToProductDetail:(RHFProductModel *)product{
    if ([self.delegate respondsToSelector:@selector(goToProductDetail:)]) {
        [self.delegate goToProductDetail:product];
    }
}

- (void)unLockSkinPackage{
    if ([self.delegate respondsToSelector:@selector(unLockSkinPackage)]) {
        [self.delegate unLockSkinPackage];
    }
}
#pragma mark - RHFHomeHeaderRankCellDelegate
- (void)goToJapanRank{
    if ([self.delegate respondsToSelector:@selector(goToJapanRank)]) {
        [self.delegate goToJapanRank];
    }
}

- (void)goToKoreaRank{
    if ([self.delegate respondsToSelector:@selector(goToKoreaRank)]) {
        [self.delegate goToKoreaRank];
    }
}


#pragma mark — CollectionViewDelegate
//返回每组中块的个数
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.selectedTags.count>0) {
        return self.selectedTags.count;
    }
    return 1;
}

//每行的块的样式
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RHFSkinNoteSelectTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RHFSkinNoteSelectTagCell" forIndexPath:indexPath];
    if (self.selectedTags.count>0) {
        cell.tagModel = self.selectedTags[indexPath.item];
        cell.isHighlighted = YES;
    }
    else{
        RHFArticleTagModel *emptyTagModel = [[RHFArticleTagModel alloc]init];
        emptyTagModel.key = @"";
        emptyTagModel.val = @"选择标签";
        cell.tagModel = emptyTagModel;
        cell.isHighlighted = NO;
    }
    return cell;
}

//每块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeZero;
    if (self.selectedTags.count>0) {
        RHFArticleTagModel *tagModel = self.selectedTags[indexPath.item];
        itemSize = CGSizeMake(tagModel.textWidth+20, 26);
    }else{
        itemSize = CGSizeMake(70, 26);
    }
    return itemSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagHeadrViewDidSelectTagAtIndex:)]) {
        [self.delegate tagHeadrViewDidSelectTagAtIndex:indexPath.item];
    }
}

- (IBAction)sortBtnPress:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagHeadrViewSortBtnPress)]) {
        [self.delegate tagHeadrViewSortBtnPress];
    }
}
@end
