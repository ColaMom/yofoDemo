//
//  RHFHomeHeaderSkinCell.h
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/4/19.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "BaseCell.h"
@class RHFProductModel;
@protocol RHFHomeHeaderSkinCellDelegate <NSObject>
- (void)goToProductDetail:(RHFProductModel*)product;
- (void)unLockSkinPackage;
@end


@interface RHFHomeHeaderSkinCell : BaseCell
@property (nonatomic,strong)NSArray *dataSource;
@property (weak, nonatomic) id<RHFHomeHeaderSkinCellDelegate> delegate;

@end
