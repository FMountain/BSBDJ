//
//  NSData+A3Extension.h
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (A3Extension)
/**
 *  是否为今天, 昨天,明天,今年
 */
- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isTomorrow;
- (BOOL)isThisYear;

@end
