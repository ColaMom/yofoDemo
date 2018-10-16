//
//  RHFHomeHeaderSkinCell.m
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/4/19.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "RHFHomeHeaderSkinCell.h"
#import "RHFHomeSingleProductCell.h"
static NSString *const RHFHomeSingleProductCellID = @"RHFHomeSingleProductCell";

@interface RHFHomeHeaderSkinCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *skinTypeLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *noSkinTypeView;
@property (weak, nonatomic) IBOutlet UIView *skinView;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet UIButton *unLockBtn;

@end

@implementation RHFHomeHeaderSkinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.collectionView registerNib:[UINib nibWithNibName:RHFHomeSingleProductCellID bundle:nil] forCellWithReuseIdentifier:RHFHomeSingleProductCellID];
    [self.unLockBtn rounded:10];
    [self.skinTypeLabel rounded:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    if (IsEmptyValue([RHFUserModel currentUser].skinType)) {
        self.skinTypeLabel.text = @"";
        self.promptLabel.text = @"";
    }
    else{
        self.skinTypeLabel.text = RRStr(@"我的肤质:%@", [RHFUserModel currentUser].skinType);
        self.promptLabel.text = @"匹配度最高单品";
    }
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView reloadData];
    if (self.dataSource.count>0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }

    if (![RHFUserModel currentUser].status || IsEmptyValue([RHFUserModel currentUser].skinType)) {
        self.noSkinTypeView.hidden = NO;
    }
    else{
        self.noSkinTypeView.hidden = YES;
    }
    
}

#pragma mark -UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RHFHomeSingleProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RHFHomeSingleProductCell" forIndexPath:indexPath];
    cell.productModel = self.dataSource[indexPath.item];
    return cell;
}

//每块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(50, collectionView.height);

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(goToProductDetail:)]) {
        [self.delegate goToProductDetail:self.dataSource[indexPath.item]];
    }
}

- (IBAction)unLockAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(unLockSkinPackage)]) {
        [self.delegate unLockSkinPackage];
    }
}

@end
