//
//  NSData+A3Extension.m
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "NSDate+A3Extension.h"

@implementation NSDate (A3Extension)

/**
 *  是否为今天, 昨天,明天,今年
 */
- (BOOL)isToday
{
    NSCalendar *calendar       = [NSCalendar currentCalendar];

    NSCalendarUnit unit        = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];

    NSDateComponents *nowCmps  = [calendar components:unit fromDate:[NSDate date]];

    return selfCmps.year  == nowCmps.year
        && selfCmps.month == nowCmps.month
        && selfCmps.day   == nowCmps.day;
}

- (BOOL)isYesterday
{
//    生成只有年月日的日期对象
    NSDateFormatter *fmt   = [[NSDateFormatter alloc] init];
    fmt.dateFormat         = @"yyyy-MM-dd";

    NSString *selfString   = [fmt stringFromDate:self];
    NSDate *selfDate       = [fmt dateFromString:selfString];

    NSString *nowString    = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate        = [fmt dateFromString:nowString];

    //比较差距
    NSCalendar *calendar   = [NSCalendar  currentCalendar];
    NSCalendarUnit unit    = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];

    return  cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

- (BOOL)isTomorrow
{
    //    生成只有年月日的日期对象
    NSDateFormatter *fmt   = [[NSDateFormatter alloc] init];
    fmt.dateFormat         = @"yyyy-MM-dd";
    
    NSString *selfString   = [fmt stringFromDate:self];
    NSDate *selfDate       = [fmt dateFromString:selfString];
    
    NSString *nowString    = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate        = [fmt dateFromString:nowString];
    
    //比较差距
    NSCalendar *calendar   = [NSCalendar  currentCalendar];
    NSCalendarUnit unit    = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return  cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger selfYear   = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear    = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    return selfYear == nowYear;
}
@end
