//
//  BaseController.m
//  RHFAPPDemo
//
//  Created by ShaoShanPeng on 2017/7/26.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBGColor;
    
    //navigationBar.translucent = YES时, 设置View的上边距;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
        // 1.取消下载
    [mgr cancelAll];
    
        // 2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}


@end
