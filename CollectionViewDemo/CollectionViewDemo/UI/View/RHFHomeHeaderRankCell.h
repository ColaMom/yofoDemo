//
//  RHFHomeHeaderRankCell.h
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/4/19.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "BaseCell.h"

@protocol RHFHomeHeaderRankCellDelegate <NSObject>
- (void)goToJapanRank;
- (void)goToKoreaRank;
@end

@interface RHFHomeHeaderRankCell : BaseCell
@property (weak, nonatomic) id<RHFHomeHeaderRankCellDelegate> delegate;

@end
