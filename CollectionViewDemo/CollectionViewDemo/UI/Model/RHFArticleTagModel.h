//
//  RHFArticleTagModel.h
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/3/16.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "BaseModel.h"
@class RHFArticleTagModel;
@class CLTagButton;


@interface RHFArticleTagModel : BaseModel
/// 英文
@property (copy ,nonatomic) NSString *key;
/// 中文
@property (copy ,nonatomic) NSString *val;

///自定义属性,在护肤笔记筛选时,用来标识该标签是否已选
@property (assign, nonatomic) BOOL isSelected;

@property (strong, nonatomic)NSIndexPath* tagIndexPath;

/// 计算得到标签的宽度
@property (assign, nonatomic) CGFloat textWidth;

@end

