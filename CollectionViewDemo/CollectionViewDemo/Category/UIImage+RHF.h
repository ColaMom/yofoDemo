//
//  UIImage+EMM.h
//  CategoryManager
//
//  Created by  ZhuHong on 2017/2/22.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RHF)

/**
 * 一般用于全局的图片获取
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 * 返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

/** 
 * 返回一张自由拉伸的图片, 有比例
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 * 根据颜色获取一个纯色的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

/**
 绘制圆角图片
 */
- (instancetype)bt_circleImageWithRadius:(CGFloat)radius sizeToFit:(CGSize)size;


/**
 *  重新绘制图片
 *
 *  @param color 填充色
 *  @return UIImage
 */
- (UIImage *)imageWithTintColor:(UIColor *)color;


/**
 截屏

 @param view 要截取的视图
 */
+ (UIImage *)imageWithCaputureView:(UIView *)view;


/**
 高斯模糊图片滤镜

 @param image 原图
 @param blur 模糊半径
 */
+ (UIImage *)blurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

//指定宽度按比例缩放
+ (UIImage *)imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
