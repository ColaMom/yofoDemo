//
//  RHFHomeModulesModel.h
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/5/10.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "BaseModel.h"
#import "RHFArticleModel.h"
@interface RHFHomeModulesModel : BaseModel

//是否可点(轮播用)
@property (assign, nonatomic) BOOL is_click ;

///网页链接
@property (copy, nonatomic) NSString* link;


//模块图片
@property (nonatomic,copy) NSString *image;
//模块类型
//测肤:skin_test,试用:trial,话题:topic,主题:theme,     测评:yofo_evaluation,达人笔记:note,热点话题列表:topic_list,     优质主题列表:theme_list
//链接:web
//帮你买:wish_list
@property (nonatomic,copy) NSString *type;
//话题或主题的id
@property (nonatomic,copy) NSString *sub_id;
//话题或主题类型
@property (nonatomic,copy) NSString *sub_type;
//话题或主题的标题
@property (nonatomic,copy) NSString *title;
//是否已经收藏了主题或话题
@property (nonatomic,assign) BOOL is_collect;
//是否显示收藏
@property (nonatomic,assign) BOOL show_collect;
//话题或主题的简介
@property (copy, nonatomic) NSString* introduction;

//@property (nonatomic,strong) NSMutableArray<RHFArticleModel*> *article_list;
//话题或主题的封面
@property (nonatomic,copy) NSString *cover_url;

@end
