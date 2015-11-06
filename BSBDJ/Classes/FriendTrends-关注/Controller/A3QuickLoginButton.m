//
//  A3QuickLoginButton.m
//  BSBDJ
//
//  Created by mac on 15/11/6.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3QuickLoginButton.h"

@implementation A3QuickLoginButton

- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5; //每个按钮宽度的一半也就是 居中.
    
    //设置文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}
@end
