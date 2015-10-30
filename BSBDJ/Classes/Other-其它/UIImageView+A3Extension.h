//
//  UIImageView+A3Extension.h
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (A3Extension)

/**
 *  默认的方式设置头像(默认是圆形)
 */
- (void)setHeaderWithURL:(NSString *)url;

/**
 *  设置圆形头像
 */
- (void)setCircleHeaderWithURL:(NSString *)url;
/**
 *  设置方形头像
 */
- (void)setRectHeaderWithURL:(NSString *)url;
@end
