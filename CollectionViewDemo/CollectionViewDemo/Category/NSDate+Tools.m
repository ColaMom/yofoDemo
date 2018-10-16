//
//  NSDate+Tools.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/7/29.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "NSDate+Tools.h"

@implementation NSDate (Tools)

+ (NSString *)currentTimeStamp{
    NSDate *date = [NSDate date];
    NSTimeInterval ti = [date timeIntervalSince1970];
    NSString *timeStamp = RRStr(@"%ld",(long)ti );
    return timeStamp;
}


- (NSString *)dateFormatWithYearMonthDayHavaTime:(BOOL)hava{
    if (hava) {
        return [self dateFormatWithFormatString:@"yyyy-MM-dd HH:mm"];
    }
    else{
       return [self dateFormatWithFormatString:@"yyyy-MM-dd"];
    }
}

- (NSString *)dateFormatWithHoursAndMinuteUseAM:(BOOL)useAM{
    NSString *timeStr = [self dateFormatWithFormatString:@"hh:mm"];
    if (!useAM) {
        return timeStr;
    }else{
        NSInteger timeInt = ((NSInteger)self.timeIntervalSince1970) % 86400;
        if (timeInt<14400) {    ///12点时刻的时间戳
            return [NSString stringWithFormat:@"上午%@",timeStr];
        }else{
            return [NSString stringWithFormat:@"下午%@",[[NSDate dateWithTimeIntervalSince1970:timeInt-43200] dateFormatWithFormatString:@"hh:mm"]];
        }
    }
}

- (NSString *)dateFormatWithFormatString:(NSString *)formatString{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.calendar = NSCalendar.currentCalendar;
    //东八区时间
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setDateFormat:formatString];
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateFromFormatString:(NSString *)dateString format:(NSString *)format{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *newDate = [formatter dateFromString:@"2016-12-07 14:06:24 +0800"];
    return newDate;
}

@end
