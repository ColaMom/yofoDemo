//
//  UINavigationBar+BottomShadow.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/4/9.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "UINavigationBar+BottomShadow.h"

@implementation UINavigationBar (BottomShadow)

- (void)bottomShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity{
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
    
}
@end
