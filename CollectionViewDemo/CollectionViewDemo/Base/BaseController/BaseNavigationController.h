//
//  NavigationController.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/7/26.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseNavigationControllerDelegate <NSObject>

- (void)popToLastViewController;

@end

@interface BaseNavigationController : UINavigationController

@property (weak, nonatomic) id myDelegate;

@end
