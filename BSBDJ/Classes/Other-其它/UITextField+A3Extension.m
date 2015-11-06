//
//  UITextField+A3Extension.m
//  BSBDJ
//
//  Created by mac on 15/11/6.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UITextField+A3Extension.h"

static NSString *const A3PlaceholderColorKey = @"placeholderLabel.textColor";
@implementation UITextField (A3Extension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    if (placeholderColor == nil) {
        //清空占位文字颜色,恢复默认的占位文字颜色
        [self setValue:A3GrayColor(255 * 0.7) forKeyPath:A3PlaceholderColorKey];
    } else {
        //保存之前的占位文字
        NSString *placeholder = self.placeholder;
        //保证placeholderColorLabel 被创建
        self.placeholder = @" ";
        [self setValue:placeholderColor forKeyPath:A3PlaceholderColorKey];
        
        //恢复之前的占位文字
        self.placeholder = placeholder;
    }
}

- (UIColor *)placeholderColor
{
    return  [self valueForKeyPath:A3PlaceholderColorKey];
}
@end
