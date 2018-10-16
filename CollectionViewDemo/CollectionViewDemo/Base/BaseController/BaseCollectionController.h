//
//  BaseCollectionController.h
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/3/3.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

// 表视图跟控制器,自动已经有了一个UICollectionView

#import "BaseController.h"

@interface BaseCollectionController : BaseController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak, readonly) UICollectionView* collectionView;

@end
