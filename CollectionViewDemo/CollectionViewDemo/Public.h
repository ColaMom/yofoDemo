//
//  Public.h
//  RHFAPPDemo
//
//  Created by ShaoShanPeng on 2017/7/26.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// MARK: 定义常量
///** 服务器地址 */
UIKIT_EXTERN NSString *const kNetWorkServiceAddress;

UIKIT_EXTERN NSString *const KH5erviceAddress;

///证书名称(正式和测试)
UIKIT_EXTERN NSString *const KCerNameForClient;
UIKIT_EXTERN NSString *const KCerNameForServer;

//动画时长
UIKIT_EXTERN CGFloat const KAnimationDuration;
//登录故事版
UIKIT_EXTERN NSString* const kStoryBoardNameOfLogin;
//个人中心故事版
UIKIT_EXTERN NSString* const kStoryBoardNameOfPersonal;


// MARK: 定义通知名称
/** 通知 */
/// 导航栏隐藏
UIKIT_EXTERN NSString *const RHFNavigationBarHiddenNotification;
/// 愿望清单进入编辑
UIKIT_EXTERN NSString *const RHFWishListEditNotification;
/// 登录成功
UIKIT_EXTERN NSString *const RHFLoginCompleteNotification;
/// 登录失败
//UIKIT_EXTERN NSString *const RHFLoginFailedNotification;

///退出登录
UIKIT_EXTERN NSString *const RHFLogOutCompleteNotification;
/// 个人资料被修改
UIKIT_EXTERN NSString *const RHFPersonalInfoModifyNotification;
/// 收藏文章成功
UIKIT_EXTERN NSString *const RHFArticleCollectSuccessNotification;
///收藏的内容发生数量变化的通知
UIKIT_EXTERN NSString *const RHFCollectionNumberChangeNotification;

/// 转移文章成功
UIKIT_EXTERN NSString *const RHFArticleTransferSuccessNotification;

/// 测试肤质提交完成,后退到测试结果页面
UIKIT_EXTERN NSString *const RHFSkinTestCompleteNotification;


#pragma mark 获取缓存,相应的key
///获取用户资料
UIKIT_EXTERN NSString *const RHFUserInfoKey;
///获取草稿箱
UIKIT_EXTERN NSString *const RHFCacheArticleKey;
//富文本编辑的草稿
UIKIT_EXTERN NSString *const RHFCacheRichTextArticleKey;

//未登录时测肤结果的key
UIKIT_EXTERN NSString *const RHFSkinTestResultStrWhenNotLogin;

static CGFloat const KNavigationBarScrollOffset = 100.0;


//UIKIT_EXTERN NSString *const KRHFDataBaseArticleTableName;



//#ifndef    weakify_self
//#define weakify_self         __weak typeof(self) weakSelf = self
//#endif
//
//#ifndef    strongify_self
//#define strongify_self       __typeof__(weakSelf) self = weakSelf
//#endif

#define weakify(var)   __weak typeof(var) weakSelf = var
#define strongify(var) __strong typeof(var) strongSelf = var


// MARK: 宏定义

#define kSuccess [dataObject[@"status"] isEqualToString:@"success"]
#define KMessage dataObject[@"message"]



///获取文章详情的URL
//#define KArticleDetailURLWithID(ARTICLEID,USERID) RRStr(@"http://st.yofo100.com/article/detail?articleId=%@&userId=%@",ARTICLEID,USERID)

#define KArticleDetailURLWithID(ARTICLEID,USERID) RRStr(@"%@article/detail?articleId=%@&userId=%@",KH5erviceAddress,ARTICLEID,USERID)

//获取心得详情的URL
#define KFeelDetailURLWithID(PRODUCTID,HEARTID,USERID) RRStr(@"%@product/commentDetail?productId=%@&commentId=%@&userId=%@",KH5erviceAddress,PRODUCTID,HEARTID,USERID)

///试用报告的URL
#define KRecordDetailURLWithID(ID,userId,isShare) RRStr(@"%@trialReport/detail?trialReportId=%@&userId=%@&isShare=%d",KH5erviceAddress,ID,userId,isShare)

#pragma mark 分享链接
///分享文章的URL
#define KShareArticleDetailURLWithID(ID,isShare) RRStr(@"%@article/detail?articleId=%@&isShare=%d",KH5erviceAddress,ID,isShare)

//分享心得的URL
#define KShareFeelDetailURLWithID(PRODUCTID,ID,isShare) RRStr(@"%@product/commentDetail?productId=%@&commentId=%@&isShare=%d",KH5erviceAddress,PRODUCTID,ID,isShare)

///分享试用报告的URL
#define KShareRecordDetailURLWithID(ID,isShare) RRStr(@"%@trialReport/detail?trialReportId=%@&isShare=%d",KH5erviceAddress,ID,isShare)

//产品试用分享
#define KProbationalDetailURLWithID(ID,UserID,isShare) RRStr(@"%@trial/detail?trialId=%@&userId=%@&isShare=%d",KH5erviceAddress,ID,UserID,isShare)

///分享产品URL
#define KProductDetailURL(ID,isShare)   RRStr(@"%@product/detail?productId=%@&isShare=%d",KH5erviceAddress,ID,isShare)

///分享产品评论的URL
#define KProductCommentDetailURLWithProductIDAndCommentID(ProdcutID,CommentID,isShare) RRStr(@"%@product/commentDetail?productId=%@&commentId=%@&isShare=%d",KH5erviceAddress,ProdcutID,CommentID,isShare)

///分享肤质检测结果URL
#define KSkinTestResultURLWithUserID(ID,isShare) RRStr(@"%@test/faceInfo?userId=%@&isShare=%d",KH5erviceAddress,ID,isShare)


//关于我们
#define KAboutUs    RRStr(@"%@about/index.html",KH5erviceAddress)
//注册协议
#define KRegistProtocol RRStr(@"%@about/agreement.html",KH5erviceAddress)
//产品帮助
#define KProductHelp     RRStr(@"%@about/helpSource.html",KH5erviceAddress)
//成分详情
#define  KElementHelp   RRStr(@"%@about/helpDetail.html",KH5erviceAddress)
//浇水攻略
#define  KWaterStrategy   RRStr(@"%@about/waterStrategy.html",KH5erviceAddress)


#define RRStr(...) [NSString stringWithFormat:__VA_ARGS__]
#define CGRM(X, Y, W, H) CGRectMake((X), (Y), (W), (H))
#define CGMinX(_obj) CGRectGetMinX(_obj.frame)
#define CGMaxX(_obj) CGRectGetMaxX(_obj.frame)
#define CGMinY(_obj) CGRectGetMinY(_obj.frame)
#define CGMaxY(_obj) CGRectGetMaxY(_obj.frame)
#define CGWidth(_obj) CGRectGetWidth(_obj.frame)
#define CGHeight(_obj) CGRectGetHeight(_obj.frame)

// 颜色的简单构成宏
#define RGBA(R, G, B, A) ([UIColor colorWithRed:(R / 255.0) green:(G / 255.0) blue:(B / 255.0) alpha:A])

#define RGB(R, G, B)       RGBA(R,G,B,1)
#define KKeyWindow  [UIApplication sharedApplication].keyWindow


// 打印日志
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif



/** 字体大小快速设置 */
#define RRFont(size) [UIFont systemFontOfSize:(size)]
//粗体
#define RRBFont(size) [UIFont boldSystemFontOfSize:(size)]


// MARK: 常用高度
/** 状态栏的宽度 */
    //#define KStatusBarWidth  ([[UIApplication sharedApplication] statusBarFrame].size.width)
/** 状态栏的高度 */
#define KStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
/** 导航栏的高度*/
#define KNavigationBarHeight (self.navigationController.navigationBar.bounds.size.height)
/** 状态栏导航栏高度*/
#define KStatusBarAndNavigationBarHeight    (KStatusBarHeight+KNavigationBarHeight)
/** 页面的上边距*/
//#define KTopLayoutMargin    (self.navigationController.navigationBar.translucent ? KStatusBarAndNavigationBarHeight : KNavigationBarHeight)
#define KTopLayoutMargin   KStatusBarAndNavigationBarHeight
///TabBar高度
#define KTabBarHeight       (self.tabBarController.tabBar.height)
/** 当前活动Window */
#define KKeyWindow     [UIApplication sharedApplication].keyWindow
/** 屏幕宽高 */
#define KScreenWidth         ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight        ([[UIScreen mainScreen] bounds].size.height)

#define KBottomToolBarHeight   ([UIDevice is_iPhoneX] ? 70 : 50 )
/**发布文章时封面高度*/
#define  kTopCoverHeight 200
/**发布文章时键盘工具栏高度*/
#define  kKeboardToolHeight 40
/*发布文章时标题的字数*/
#define  kPublishArticleTitleLenth 20

//上传到七牛的类型
#define kMediaTypeImage  @"mediaTypeImage"
#define kMediaTypeGif    @"mediaTypeGif"
#define kMediaTypeVideo @"mediaTypeVideo"

//话题的类型
#define kTopicTypeNormal 1         //普通话题:下方直接参与       样式:顶部正常,底部文章             @"RHFTopicDetailVC.h"
#define kTopicTypeOversea   2         //人在海外:下方直接参与       样式:顶部正常,底部分组(地区)        @"RHFTopicDetailWithGroupVC.h"
#define kTopicTypeQA      3         //大神问答:下方直接参与       样式:顶部正常,底部文章,中间带排序    @"RHFQuestionAnswerVC.h"

//主题类型
#define kThemeTypeSignUp  4         //Hello 男神:报名参与       样式:顶部报名,底部文章              @"RHFTopicDetailVC.h"
#define kThemeTypeVideo   5    //优质主题:不可参与          样式:顶部正常,底部视频              @"RHFTopicDetailVC.h"
#define kThemeTypeNormal 6    //优质主题:不可参与          样式:顶部正常,底部文章              @"RHFTopicDetailVC.h"


//发布文章的类型
#define kPublishArticleTypeDefault  1   //普通文章   标签+内容（可加产品）
#define kPublishArticleTypeHotTopic  2  //话题文章   标签+内容（可加产品）
#define kPublishArticleTypeOverSea  3   //人在海外   标签+位置+内容（可加产品）

#define kPublishArticlePlaceholderStr    @"1、图片精美，更容易上热搜哦；\n2、试试产品卡片吧，节省打字时间；\n3、内容层次丰富，容易被提为加V用户增加曝光量哦。"

//文章列表中的文章类型,是文章还是心得
#define kListTypeArticle  @"article"  //文章
#define kListTypeHeart  @"heart"  //心得

//文章列表排序类型
#define kArticleSortTypePraise  @"praise"  //热门
#define kArticleSortTypeNewest  @"add_time"  //最新
//话题的排序
#define kTopicSortTypePraise  @"fabulous_number"  //热门
#define kTopicSortTypeNewest  @"add_time"  //最新

//肤质标签的内间距
#define kSkintypeEdgeInsets UIEdgeInsetsMake(0, 6, 0, 6)

#define  kRandomBackgroundColorArray  [NSMutableArray arrayWithArray:@[@"#FCECD2",@"#E3D1CA",@"#E3CAD0",@"#CBBED8",@"#C2C9DB",@"#BECFC2"]]

//评论和文章的名字
#define heartName @"评论"
#define articleName @"笔记"

//====== 判断检查型方法 =========
// 空值判断
static inline BOOL IsEmptyValue(id thing) {
    return thing == nil
        || ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0)
        || ([thing respondsToSelector:@selector(count)] && [(NSArray *)thing count] == 0)
        || ([thing isKindOfClass:[NSNull class]]);
}

/** 对字符串的特殊处理,如果为空,则统一返回@"",否则原形 */
static inline NSString* checkValue (NSString* value) {
    if (IsEmptyValue(value)) {
        return @"";
    }
    return value;
}

/** 对字符串的特殊处理,如果为空,则统一返回nil,否则原形 */
static inline NSString* checkValueNil (NSString* value) {
    if (IsEmptyValue(value)) {
        return nil;
    }
    return value;
}


/**
 *检查肤质类型,如果为空,返回暂无
 */
static inline NSString* checkSkinType (NSString* value) {
    if (IsEmptyValue(value)) {
        return @"暂无肤质";
    }
    return value;
}



@interface Public : NSObject

/** 从故事版中获取对应的控制器
 storyboardName  故事版文件名
 identifier      对应控制器的标识, 为nil,则是instantiateInitialVC
 */
+ (id)vcFromStoryboardWithName:(NSString*)storyboardName identifier:(NSString*)identifier;


///** 显示加载框 */
//+ (void)showLoadingView;

/** 隐藏加载框 */
+ (void)hideLoadingView;



@end
