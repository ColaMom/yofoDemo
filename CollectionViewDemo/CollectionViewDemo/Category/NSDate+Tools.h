//
//  NSDate+Tools.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/7/29.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Tools)

//返回当前时间的时间戳
+ (NSString *)currentTimeStamp;

/**
 返回该NSDate的格式化时间
 */
- (NSString *)dateFormatWithYearMonthDayHavaTime:(BOOL)hava;
/**
 将该时间戳转化为时钟字符串

 @param useAM 是否采用12小时制
 */
- (NSString *)dateFormatWithHoursAndMinuteUseAM:(BOOL)useAM;

/**
 按照格式串返回时间串

 @param formatString 格式串
 */
- (NSString *)dateFormatWithFormatString:(NSString *)formatString;

+ (NSDate*)dateFromFormatString:(NSString *)dateString format:(NSString *)format;


@end
