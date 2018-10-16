//
//  UIColor+RGBA.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/9/27.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGBA)

/**
 获取UIColor的RGB

 @param components 得到的rgb值数组
 @param color 原UIColor
 */
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color;


/**
 通过hex颜色字符串创建颜色

 @param hexString 格式为"#FAFAFA" 的色值字符串
 @return 返回一个UIColor
 */
+ (UIColor *)colorWithHex:(NSString *)hexString;

@end
