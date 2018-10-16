//
//  NSString+Verify.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/10/12.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)

/**
 *判断输入的是否为纯空格混合换行
 */
- (BOOL)isAllSpace;

/**
 *判断输入是否为换行
 */
- (BOOL)isAllBreak;

//因为各个运营商开头号码不同，这里只匹配11位是比较好的方法
- (BOOL)isValidPhoneNumber;
//邮箱
- (BOOL)isValidEmail;

@end
