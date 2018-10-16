//
//  UINavigationBar+BottomShadow.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/4/9.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BottomShadow)

- (void)bottomShadowWithOffset:(CGSize)offset
                        radius:(CGFloat)radius
                         color:(UIColor *)color
                       opacity:(CGFloat)opacity;
@end
