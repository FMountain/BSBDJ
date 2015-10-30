//
//  A3Topic.m
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3Topic.h"

@implementation A3Topic

- (NSString *)created_at
{
//服务器返回的日期
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat =@"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt dateFromString:_created_at];
    
    if (createdAtDate.isThisYear) { //今年
        if (createdAtDate.isToday) { //今天
            //当前时间
            NSDate *nowDate = [NSDate date];
            //日历对象
            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar components:unit fromDate:createdAtDate toDate:nowDate options:0];
            if (cmps.hour >= 1) //时间>=1小时
            {
                return  [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1) // >=1分钟
            {
                return  [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }

        }else if (createdAtDate.isYesterday) //昨天
        {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return  [fmt stringFromDate:createdAtDate];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }
        
    }else { //非今年
        return  _created_at;
    }
}
@end
