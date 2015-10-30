//
//  UIImage+A3Extension.m
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UIImage+A3Extension.h"

@implementation UIImage (A3Extension)

- (instancetype)circleImage
{
    //开启图片上下文字(目的:产生一个新的UIImage,参数size)
    UIGraphicsBeginImageContext(self.size);
    
    //获得上下文
    CGContextRef  context = UIGraphicsGetCurrentContext();
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    
    //根据上下文裁剪
    // 超出裁剪的内容都看不见
    CGContextClip(context);
    //绘制图片到上下文中
    [self drawInRect:rect];
    
    //从上下文中获得最终的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsGetCurrentContext();
    
    return image;
}

+ (instancetype)circleImageNamed:(NSString *)name
{
    return  [[self imageNamed:name] circleImage];
}
@end
