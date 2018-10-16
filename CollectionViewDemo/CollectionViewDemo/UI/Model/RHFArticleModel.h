//
//  RHFArticleListModel.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/10/9.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "BaseModel.h"


typedef enum : NSUInteger {
    RHFArticleModeMulti,    //多图
    RHFArticleModeLarge,    //大图
    RHFArticleModeSmall,    //小图
} RHFArticleMode;

@interface RHFArticleModel : BaseModel

/// 文章发布者ID
@property (copy, nonatomic) NSString* userId;
@property (copy, nonatomic) NSString* user_id;
@property (nonatomic,copy) NSString *v;


@property (copy, nonatomic) NSString* skinType;
///创建时间
@property (assign, nonatomic) NSInteger add_time;
/// 用户头像
@property (copy, nonatomic) NSString* userImage;
///用户等级
@property (copy, nonatomic) NSString* grade;
///昵称
@property (copy, nonatomic) NSString* nickname;
//文章类型,是文章还是心得
@property (nonatomic,copy) NSString *list_type;


/// 封面
@property (copy, nonatomic) NSString* image;//在护肤笔记列表的时候变成了用户头像, 在编辑文章时,是封面
///封面数组(小于3张)
@property (strong, nonatomic)NSMutableArray* image_list;
///文章排版样式(三种, 大小多图)
@property (copy, nonatomic) NSString* displayMode;
///将displayMode转换成枚举值方便使用(自定义属性)
@property (assign, nonatomic) RHFArticleMode displayModeEnum;

///文章ID
@property (copy, nonatomic) NSString* articleId;
@property (copy, nonatomic) NSString* article_id;

///收藏夹id, 用于我收藏
@property (copy, nonatomic) NSString* collectId;
///文章标题
@property (copy, nonatomic) NSString* title;
/// 简介
@property (copy, nonatomic) NSString* descript;
/// 封面
@property (copy, nonatomic) NSString* cover;

@property (copy, nonatomic) NSString* articleImage;
@property (copy, nonatomic) NSString* article_image;

///是否已关注该文章的作者
@property (assign, nonatomic) BOOL isAttention;
///点赞数
@property (copy, nonatomic) NSString* praise;
///是否已点赞
@property (assign, nonatomic) BOOL isPraise;
///评论数
@property (copy, nonatomic) NSString* comment;
///评论数
@property (copy, nonatomic) NSString* comment_num;
///收藏数
@property (copy, nonatomic) NSString* collect;
///是否已收藏
@property (assign, nonatomic) BOOL isCollect;
///分享数
@property (copy, nonatomic) NSString* share;
//浏览次数
@property (copy, nonatomic) NSString* view_times;
//视频时长
@property (copy, nonatomic) NSString* duration;

/// 发布文章时的模块内容
@property (strong, nonatomic) NSString* htmlContent;//自定义,值服务器返的是content

/**
 *自定义的属性,用于编辑文章记录图片
 */
///上传至七牛的封面图片名
@property (copy, nonatomic) NSString* imageDstName;
/// 文章封面的本地选择的图片(自定义属性)
@property (strong, nonatomic)UIImage* localImage;

//封面图片的宽高
@property (copy ,nonatomic) NSString *image_width;
@property (copy ,nonatomic) NSString *image_height;

//用户的标签 90后
@property (copy ,nonatomic) NSString *tag;
//是否是测评
@property (copy ,nonatomic) NSString *is_cp;
//封面类型
@property (copy ,nonatomic) NSString *is_gif;
@property (copy ,nonatomic) NSString *video;
@property (copy ,nonatomic) NSString *is_iphone;


@property (copy ,nonatomic) NSString *articleTag;//文章标签
@property (copy ,nonatomic) NSString *tags;//文章标签,编辑文章时返回来的
//文章显示产品列表
@property (copy ,nonatomic) NSString *product_show;
//产品数
@property (copy ,nonatomic) NSString *product_num;


//保存草稿时把图片保存下来,自定义
//视频必选dst,图片和内容图片可以等到发布的时候再上传
@property (assign, nonatomic) BOOL coverIsVideo ;
@property (copy ,nonatomic) NSString *coverVideoDstName;

@property (strong ,nonatomic) UIImage *coverImage;
@property (strong ,nonatomic) NSData *coverImageData;
@property (strong ,nonatomic) NSAttributedString *attr;
@property (strong ,nonatomic) NSArray *chooseTagArr;

@property (strong ,nonatomic) NSArray *imageAttachmentArr;
@property (assign ,nonatomic) NSInteger drafId;//草稿的id

//自己算的高度
@property (assign, nonatomic) CGFloat collectionWidth;
@property (assign, nonatomic) CGFloat coverImageWidth;

@property (assign, nonatomic) CGFloat titleHeight;
@property (assign, nonatomic) CGFloat descripHeight;

@property (assign, nonatomic) CGFloat coverImageHeight;


//编辑文章时使用
//是否是话题类文章
@property (nonatomic,copy) NSString *is_topic;
@property (nonatomic,copy) NSString *topic_id;
@property (nonatomic,copy) NSString *topic_type;

//发现页,四个模块中,话题列表用
@property (nonatomic,copy) NSString *topic_name;
@property (nonatomic,copy) NSString *participate_number;
@property (nonatomic,copy) NSString *cover_url;
@property (nonatomic,copy) NSString *introduction;
@property (nonatomic,copy) NSString *topic_backgroundColor;
@end


