//
//  UIView+A3Extension.h
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//由于不能直接调整对象的大小封装.
//自动调整子控件的大小

//        publishButton.frame.size.width = self.frame.size.width * 0.5;
// 不能直接修改对象的大小

//        CGRect frame = publishButton.frame;
//        frame.size = CGSizeMake(50, 40);
//        publishButton.frame = frame;

#import <UIKit/UIKit.h>

@interface UIView (A3Extension)

/** x,y,w,h */
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat centerX;
@property (nonatomic,assign)CGFloat centerY;

/** 控件 左(minX),右(maxX),上(minY),下(maxY) 那根线的位置 (minX的位置 )*/
@property (nonatomic,assign)CGFloat left;
@property (nonatomic,assign)CGFloat right;
@property (nonatomic,assign)CGFloat top;
@property (nonatomic,assign)CGFloat bottom;



@end
