//
//  RHFArticleTagSectionModel.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/4/12.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "BaseModel.h"
#import "RHFArticleTagModel.h"

@interface RHFArticleTagSectionModel : BaseModel


///组名
@property (copy, nonatomic) NSString* name;
///组内标签
@property (strong, nonatomic)NSMutableArray<RHFArticleTagModel *>* data;

@property (assign, nonatomic) NSUInteger section;

///标签文字数组
//@property (strong, nonatomic) NSArray<NSString *> *tagsArray;

//根据标签文字内容生成的每个tagModel
//@property (strong, nonatomic) NSMutableArray* tagModelsArray;

///根据标签文字内容生成的标签按钮
@property (strong, nonatomic) NSArray<CLTagButton *> *tagBtnArray;


@end
