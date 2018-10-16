//
//  RHFUserSkinNoteStyleCell.h
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/3/3.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RHFArticleModel.h"
@interface RHFUserSkinNoteStyleCell : UICollectionViewCell

@property (strong, nonatomic)RHFArticleModel* articleModel;
@property (nonatomic, copy) void(^praiseArticleBlock)(RHFArticleModel *articleModel);
@end
