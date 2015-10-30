//
//  UIView+A3Extension.m
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
/*
         publishButton.frame.size.width = self.frame.size.width * 0.5;
  不能直接修改对象的大小
 
         CGRect frame = publishButton.frame;
         frame.size = CGSizeMake(50, 40);
         publishButton.frame = frame;
 */

#import "UIView+A3Extension.h"

@implementation UIView (A3Extension)

/** frame.origin.x */
- (void)setX:(CGFloat)x
{
    CGRect frame   = self.frame;
    frame.origin.x = x;
    self.frame     = frame;
}
/** frame.origin.x */
- (CGFloat)x
{
    return  self.frame.origin.x;
}

/** frame.origin.y */
- (void)setY:(CGFloat)y
{
    CGRect frame   = self.frame;
    frame.origin.y = y;
    self.frame     = frame;
}

- (CGFloat)y
{
    return  self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame     = self.frame;
    frame.size.width = width;
    self.frame       = frame;
}
/** frame.size.width */
- (CGFloat)width
{
    return  self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame      = self.frame;
    frame.size.height = height;
    self.frame        = frame;
    
}
/** frame.size.height */
- (CGFloat)height
{
    return  self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x       = centerX;
    self.center    = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y       = centerY;
    self.center    = center;
}
- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setLeft:(CGFloat)left
{
    self.x = left;
}
- (CGFloat)left
{
    return self.x;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)right
{
    return  CGRectGetMaxX(self.frame);
}

- (void)setTop:(CGFloat)top
{
    self.y = top;
}
- (CGFloat)top
{
    return self.y;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom = frame.size.height;
    self.frame = frame;
}
- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}
@end
