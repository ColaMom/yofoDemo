//
//  NSString+Verify.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/10/12.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "NSString+Verify.h"

@implementation NSString (Verify)


    //判断输入的是否为纯空格混合换行
- (BOOL)isAllSpace{
    NSString *breakString = [self  stringByReplacingOccurrencesOfString:@"\n" withString:@" "];

    NSString *string = [breakString  stringByReplacingOccurrencesOfString:@" " withString:@""];

    return [string isEqualToString:@""];
}

/**
 *判断输入是否为换行
 */
- (BOOL)isAllBreak
{
    NSString *str = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return [str isEqualToString:@""];
}

/**
 *因为各个运营商开头号码不同，这里只匹配11位是比较好的方法
 */
- (BOOL)isValidPhoneNumber {
    NSString *regex = @"^[0-9]{11}";
    return [self isValidateByRegex:regex];
}

/**
 *判断邮箱
 */
- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateByRegex:emailRegex];
}



/**
 *负责正则校验结果
 */
- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

@end
