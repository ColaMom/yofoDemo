//
//  RHFSkinNoteSelectTagCell.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/4/8.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHFArticleTagModel.h"

@interface RHFSkinNoteSelectTagCell : UICollectionViewCell

@property (strong, nonatomic)RHFArticleTagModel* tagModel;
///按钮高亮状态
@property (assign, nonatomic) BOOL isHighlighted;

@end
