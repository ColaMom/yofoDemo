//
//  UIColor+RGBA.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/9/27.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "UIColor+RGBA.h"

@implementation UIColor (RGBA)

- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    unsigned char resultingPixel[4];
    
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,1,1,8,4,rgbColorSpace,

                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(rgbColorSpace);
    
    
    
    for (int component = 0; component < 3; component++) {
        
        components[component] = resultingPixel[component] / 255.0f;
        
    }
    
}


+ (UIColor *)colorWithHex:(NSString *)hexString{
    if (hexString.length == 7) {
        NSInteger red = strtol([hexString substringWithRange:NSMakeRange(1, 2)].UTF8String, NULL, 16);
        NSInteger green = strtol([hexString substringWithRange:NSMakeRange(3, 2)].UTF8String, NULL, 16);
        NSInteger blue = strtol([hexString substringWithRange:NSMakeRange(5, 2)].UTF8String, NULL, 16);
        
        return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
    }
    return [UIColor clearColor];
}


@end
