//
//  UIBarButtonItem+A3Extension.h
//  BSBDJ
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (A3Extension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
