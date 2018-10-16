//
//  TabBarController.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/7/26.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
//#import "RHFHomeController.h"
//#import "RHFCommunityHomeVC.h"
//#import "RHFProductVC.h"
//#import "RHFPublishVC.h"


#import "BaseTabBar.h"


@interface BaseTabBarController () <BaseTabBarDelegate,UITabBarControllerDelegate>

@end


@implementation BaseTabBarController

/*
+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = KDarkColor;

    
    
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.translucent = NO;
    [tabbar setBackgroundColor:[UIColor whiteColor]];

    UITabBarItem *item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, -3);
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BaseTabBar *tabbar = [[BaseTabBar alloc]init];
    tabbar.myDelegate = self;
    [self setValue:tabbar forKey:@"tabBar"];
    self.delegate = self;
    [self setupChildViewControllers];
}


- (void)setupChildViewControllers{
    RHFHomeController *homeVC = [[RHFHomeController alloc] init];
    [self setupChildVc:homeVC title:@"首页" image:@"Home_normal" selectedImage:@"Home_selected"];
    RHFHomeController *homeVC1 = [[RHFHomeController alloc] init];
    [self setupChildVc:homeVC1 title:@"首页" image:@"Home_normal" selectedImage:@"Home_selected"];
//
//    RHFCommunityHomeVC *communityVC = [[RHFCommunityHomeVC alloc] init];
//    [self setupChildVc:communityVC title:@"发现" image:@"Community_normal" selectedImage:@"Community_selected"];
//
//    RHFProductVC *skinTestVC = [[RHFProductVC alloc] init];
//    [self setupChildVc:skinTestVC title:@"产品" image:@"Product_normal" selectedImage:@"Product_selected"];
//
//    RHFPersonalHomeVC *personalVC = [[RHFPersonalHomeVC alloc]init];
//    [self setupChildVc:personalVC title:@"我的" image:@"Personal_normal" selectedImage:@"Personal_selected"];
    
   
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    // 设置文字和图片
//    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
//    nav.tabBarItem.image = [UIImage imageNamed:image];
//    UIImage *originSelImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    nav.tabBarItem.selectedImage = originSelImage;
  
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
