//
//  Public.m
//  RHFAPPDemo
//
//  Created by ShaoShanPeng on 2017/7/26.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "Public.h"
#import "AppDelegate.h"


// MARK: 定义常量

    /** 服务器地址 正式*/
//    NSString *const kNetWorkServiceAddress = @"https://api.yofo100.com/";
    /** 服务器地址 测试*/
//    NSString *const kNetWorkServiceAddress = @"https://api-test.yofo100.com/";
NSString *const kNetWorkServiceAddress = @"http://192.168.31.139/";


//调用H5的域名
//NSString *const KH5erviceAddress = @"http://m.yofo100.com/";//正式线上的
//NSString *const KH5erviceAddress = @"http://skin.360hai.net/";
NSString *const KH5erviceAddress = @"http://192.168.31.139/";


//客户端的验证证书
//    NSString *const KCerNameForClient = @"api_client";
    NSString *const KCerNameForClient = @"api_client_test";

//服务端的验证证书
//    NSString *const KCerNameForServer = @"api_server";
    NSString *const KCerNameForServer = @"api_server_test";


CGFloat const KAnimationDuration = 0.3;
NSString * const kStoryBoardNameOfLogin = @"RHFLoginAndRegist";
NSString * const kStoryBoardNameOfPersonal = @"RHFPersonal";


// MARK: 定义通知名称

NSString *const RHFNavigationBarHiddenNotification = @"RHFNavigationBarHiddenNotification";

NSString *const RHFWishListEditNotification = @"RHFWishListEditNotification";

NSString *const RHFLoginCompleteNotification = @"RHFLoginCompleteNotification";

NSString *const RHFLoginFailedNotification = @"RHFLoginFailedNotification";

NSString *const RHFLogOutCompleteNotification = @"RHFLogOutCompleteNotification";

NSString *const RHFPersonalInfoModifyNotification = @"RHFPersonalInfoModifyNotification";

NSString *const RHFArticleCollectSuccessNotification = @"RHFArticleCollectSuccessNotification";

NSString *const RHFCollectionNumberChangeNotification = @"RHFCollectionNumberChangeNotification";

NSString *const RHFArticleTransferSuccessNotification = @"RHFArticleTransferSuccessNotification";

NSString *const RHFSkinTestCompleteNotification = @"RHFSkinTestCompleteNotification";


/**
 *获取缓存,相应的key
 */
NSString *const RHFUserInfoKey = @"RHFUserInfoKey";
NSString *const RHFCacheArticleKey = @"RHFCacheArticleKey";
NSString *const RHFCacheRichTextArticleKey = @"RHFCacheRichTextArticleKey";


//未登录时测肤结果的key
NSString *const RHFSkinTestResultStrWhenNotLogin = @"RHFSkinTestResultStrWhenNotLogin";
//NSString *const KRHFDataBaseArticleTableName = @"KRHFDataBaseArticleTableName";

@implementation Public


/** 从故事版中获取对应的控制器
 storyboardName  故事版文件名
 identifier      对应控制器的标识, 为nil,则是instantiateInitialVC
 */
+ (UIViewController*)vcFromStoryboardWithName:(NSString*)storyboardName identifier:(NSString*)identifier {
    // 跳转登录页面
    UIStoryboard  *mStb = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *mVC  = nil;
    
    if (IsEmptyValue(identifier)) {
        mVC  = [mStb instantiateInitialViewController];
    } else {
        mVC  = [mStb instantiateViewControllerWithIdentifier:identifier];
    }
    
    return mVC;
}




@end
