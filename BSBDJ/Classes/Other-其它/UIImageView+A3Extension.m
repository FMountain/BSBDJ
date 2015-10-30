//
//  UIImageView+A3Extension.m
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UIImageView+A3Extension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (A3Extension)

/**
 *  默认的方式设置头像(默认是圆形)
 */
- (void)setHeaderWithURL:(NSString *)url
{
    [self setCircleHeaderWithURL:url];
}

/**
 *  设置圆形头像
 */
- (void)setCircleHeaderWithURL:(NSString *)url
{
    UIImage *placeholder = [UIImage circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //下载失败,不做任何处理,显示占位图片
        if(image == nil)return ;
        self.image = [image circleImage];
    }];
}

/**
 *  设置方形头像
 */
- (void)setRectHeaderWithURL:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
