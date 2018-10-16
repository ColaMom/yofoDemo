//
//  AppDelegate.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/7/26.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
//#import "RHFLoadingVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

/**
 loading视图
 */
//@property (strong, nonatomic)RHFLoadingVC* loadingVC;

- (void)saveContext;

/**
 *进入主页
 */
- (void)enterHomeViewController;

/**
 进入测肤页
 */
- (void)enterSkinTestTakePhotoVC;
+ (void)checkVersion;

@end

