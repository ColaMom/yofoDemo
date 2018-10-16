//
//  RHFBannerView.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/8/10.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHFHomeModulesModel.h"

@protocol RHFBannerViewDelegate <NSObject>

- (void)RHFBannerViewDidSelectItemAtIndex:(NSInteger )index;

@end

@interface RHFBannerView : UIView

@property (nonatomic, strong) NSMutableArray* dataSource;
@property (weak, nonatomic) id<RHFBannerViewDelegate> delegate;

@end
