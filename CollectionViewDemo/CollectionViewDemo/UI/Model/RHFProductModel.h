//
//  RHFProductModel.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/11/2.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "BaseModel.h"
@class RHFProductScoreModel, RHFProductElementCompomentModel, RHFProductElementCompomentListModel,RHFProductElementItemModel;


@interface RHFProductModel : BaseModel
///产品ID
@property (copy, nonatomic) NSString* productId;
///产品名
@property (copy, nonatomic) NSString* china_name;
///产品名_韩文
@property (copy, nonatomic) NSString* kora_name;
///产品名_英文
@property (copy, nonatomic) NSString* english_name;
///品牌名
@property (copy, nonatomic) NSString* brand_china_name;
///品牌名_英文
@property (copy, nonatomic) NSString* brand_english_name;
///产品图
@property (copy, nonatomic) NSString* image;
///产品排序
@property (copy, nonatomic) NSString* sort;
///产品描述
@property (copy, nonatomic) NSString* descript;
///净含量
@property (copy, nonatomic) NSString* specification;
//价格
@property (copy, nonatomic) NSString* price;
@property (nonatomic , copy) NSString * message;
///产品所属的分类
@property (nonatomic , copy) NSString * cateId;
///评分
@property (nonatomic , assign) NSInteger score;
///评分人数
@property (nonatomic , copy) NSString * score_person;

@property (strong, nonatomic) NSMutableArray<RHFProductScoreModel *>* scoreList;

@property (nonatomic, assign) NSInteger similarity;
///安全等级
@property (nonatomic, copy) NSString* safe_grade;

///和我肤质的匹配度
@property (nonatomic , assign) NSInteger  skin_percent;
///同肤质评分
@property (nonatomic , assign) NSInteger  skin_score;
///同肤质评分人数
@property (nonatomic , assign) NSInteger  skin_score_person;

///成分总数
@property (nonatomic , assign) NSInteger component_num;
//适合我的
@property (nonatomic , assign) NSInteger suit_num;
//需注意成分
@property (nonatomic , assign) NSInteger careful_num;
//孕妇慎用成分
@property (nonatomic , assign) NSInteger pregnant_num;


///危险成分个数
@property (nonatomic , assign) NSInteger component_danger_num;
///等级未定
@property (nonatomic , assign) NSInteger component_danger_grade0_num;
///低度危险
@property (nonatomic , assign) NSInteger component_danger_grade1_num;
///中度危险
@property (nonatomic , assign) NSInteger component_danger_grade2_num;
///高度危险
@property (nonatomic , assign) NSInteger component_danger_grade3_num;
///自定义属性, 用来计算各个危险度占总危险度的比值
@property (assign, nonatomic) NSInteger component_danger_total_num;

///是否致痘
@property (nonatomic , assign) NSInteger is_beans;
//致痘成分
@property (nonatomic , assign) NSInteger beans_num;

@property (nonatomic , assign) NSInteger spice_num;


///是否已加入清单
@property (assign, nonatomic) BOOL isWish;

@property (nonatomic, strong)NSMutableArray <RHFProductElementCompomentModel *>* purposeList;

@end



@interface RHFProductElementCompomentModel : BaseModel

@property (nonatomic, copy) NSString* name;

@property (nonatomic, strong)NSMutableArray<RHFProductElementCompomentListModel *>* list;

@end


@interface RHFProductElementCompomentListModel : BaseModel

@property (nonatomic, copy) NSString* name;

@property (nonatomic, copy) NSString* listNumber;

@property (nonatomic, strong)NSMutableArray<RHFProductElementItemModel *>* list;

@end

