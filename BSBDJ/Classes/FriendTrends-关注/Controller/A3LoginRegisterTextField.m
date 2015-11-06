//
//  A3LoginRegisterTextField.m
//  BSBDJ
//
//  Created by mac on 15/11/6.
//  Copyright © 2015年 mac. All rights reserved.
////设置占位符文字的颜色

#import "A3LoginRegisterTextField.h"

@implementation A3LoginRegisterTextField

- (void)awakeFromNib
{
    self.tintColor = [UIColor whiteColor];
    self.textColor = [UIColor whiteColor];
    self.placeholderColor = [UIColor grayColor];
}

/**
 *  当文本框开始编辑的时候会调用这个方法
 */
- (BOOL)becomeFirstResponder
{
    self.placeholderColor = [UIColor whiteColor];
    return [super becomeFirstResponder];
}
@end
