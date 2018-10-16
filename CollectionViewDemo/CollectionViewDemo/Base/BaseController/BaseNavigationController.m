//
//  NavigationController.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/7/26.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UINavigationBar+BottomShadow.h"


@interface BaseNavigationController () <UINavigationBarDelegate>

@end

@implementation BaseNavigationController


// 启动初始化一次
+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:[UIColor whiteColor]];
//    navigationBar.translucent = NO;
//        [navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {
//        [navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
//    }

    
    // 统一修改控制器title的字体颜色
    NSMutableDictionary* dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    dictM[NSForegroundColorAttributeName] = KDarkColor;
    [navigationBar setTitleTextAttributes:dictM];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
        // 2.滑动返回手势
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self.navigationBar bottomShadowWithOffset:CGSizeMake(0, 2) radius:6 color:[UIColor blackColor] opacity:0.05];
}


#pragma mark 返回按钮
- (void)popself {
    if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(popToLastViewController)]) {
        [self.myDelegate popToLastViewController];
    }else{
        [self popViewControllerAnimated:YES];
    }
}

#pragma mark 创建返回按钮
- (UIBarButtonItem *)createBackButton {
    return [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popself)];
}

#pragma mark 重写方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    }
}


- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item{
        //只有一个控制器的时候禁止手势，防止卡死现象
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (self.childViewControllers.count > 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    return YES;
}


- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(nonnull UINavigationItem *)item{
        //只有一个控制器的时候禁止手势，防止卡死现象
    if (self.childViewControllers.count == 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
