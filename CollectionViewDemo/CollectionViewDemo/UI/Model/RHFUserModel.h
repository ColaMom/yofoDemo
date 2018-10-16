//
//  RHFUserModel.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/9/25.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "BaseModel.h"

typedef enum : NSUInteger {
    RHFUserAttentionStatusNotAttention,     //未关注
    RHFUserAttentionStatusAttentioned,      //已关注
    RHFUserAttentionStatusBouthAttention    //互相关注
} RHFUserAttentionStatus;


typedef enum : NSUInteger {
    RHFUserLoginWithPhoneNumber,        //以手机号密码登录
    RHFUserLoginWithCode,               //以手机验证码登录
    RHFUserLoginWithThirdPlatform       //以第三方授权登录
} RHFUserLoginType;



#define KUsefulLife     (60*60*24*15)

@interface RHFUserModel : BaseModel



/**
 *普通用户信息 ↓
 */
/// UserID
@property (copy, nonatomic) NSString* userId;
/// 昵称
@property (copy, nonatomic) NSString* nickname;
//是否为加v用户
@property (nonatomic,copy) NSString *v;

/// 头像
@property (copy, nonatomic) NSString* image;
/// 手机号
@property (copy, nonatomic) NSString* phone;
/// 验证码
@property (copy, nonatomic) NSString* checkCode;
/// 密码
@property (copy, nonatomic) NSString* password;
/// 邮箱
@property (copy, nonatomic) NSString* email;
/// 返回的性别是"男,女"字符串
@property (copy, nonatomic) NSString* sex;
/// 将性别字符串转为bool(自定义)
@property (assign, nonatomic) BOOL gender;
/// 性别对应的图案(自定义)
@property (copy, nonatomic) NSString* genderIcon;

///生日
@property (copy, nonatomic) NSString * birthday;
///等级
@property (copy, nonatomic) NSString * grade;
///肤质类型
@property (copy, nonatomic) NSString* skinType;
/// 个人签名
@property (nonatomic, copy) NSString* sig;
///封面
@property (copy, nonatomic) NSString* cover;
///成长值
@property (nonatomic, copy) NSString * grow_up;
///关注人数
@property (nonatomic, copy) NSString * attentionNum;
///粉丝人数
@property (nonatomic, copy) NSString * attentionMeNum;
///年龄标签
@property (nonatomic, copy) NSString * tag;

//长草清单权限
//当前登录人里,是所有权限
//其他用户信息,是他是否给我权限
@property (nonatomic, copy) NSString * pri;
//其他用户信息,我是否给他权限
@property (nonatomic, copy) NSString * myPri;
//长草清单数量
@property (nonatomic, copy) NSString * wishTotal;
///有培养的产品
@property (nonatomic, copy) NSString * hasTrain;
///培养等级
@property (nonatomic, copy) NSString* level;
///当前等级的培养进度
@property (nonatomic, copy) NSString* progress;


#pragma mark - 查看其他用户时的一些信息

///是否已关注
@property (assign, nonatomic) BOOL isAttention;
///是否互相关注
@property (assign, nonatomic) BOOL isMutual;

@property (assign, nonatomic) RHFUserAttentionStatus attentionStatus;

/// 关注时间
@property (copy, nonatomic) NSString* add_time;
///匹配度
@property (nonatomic , copy)  NSString     * percent;
///
@property (nonatomic , assign) NSInteger    isDisplayPercent;
///该用户的文章数
@property (nonatomic , copy)   NSString    * articleNum;
///该用户的产品评价数
@property (nonatomic , copy) NSString      * productCommentNum;




#pragma mark - 用户位置信息
///纬度
@property (assign, nonatomic) CGFloat latitude;
///经度
@property (assign, nonatomic) CGFloat longitude;
///省
@property (copy, nonatomic) NSString* administrativeArea;
///市
@property (copy, nonatomic) NSString* locality;
///区
@property (copy, nonatomic) NSString* subLocality;
///推送ID
@property (copy, nonatomic) NSString* registrationID;



/**
 登录状态  YES 已登录, NO 未登录
 */
@property (assign, nonatomic) BOOL status;
/**
 *当前用户的登录方式
 */
@property (nonatomic, assign) RHFUserLoginType loginType;

/**
 *过期时间的时间戳
 */
@property (copy ,nonatomic) NSString* expiredTimeInterval;

/**
 *获取当前用户
 */
+ (instancetype)currentUser;
/**
 更新用户信息
 */
- (void)updateUserInfoWithDictionary:(NSDictionary *)dictionary;

/**
 *退出登录, 清除当前用户信息,并清除本地保存的信息
 */
- (void)logOut;

//检查第三方登录是否过期
- (BOOL)checkExpiredDateIsAvalible;

@end
