//
//  BaseTabBar.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/2/8.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTabBarDelegate <NSObject>

- (void)BaseTabBarDidSelectedCenterItem:(UIButton *)centerBtn;

@end


@interface BaseTabBar : UITabBar

@property (weak, nonatomic) id<BaseTabBarDelegate> myDelegate;

@end
