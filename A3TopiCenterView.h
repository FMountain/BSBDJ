//
//  A3TopiCenterView.h
//  BSBDJ
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  A3Topic;
@interface A3TopiCenterView : UIView
{
    __weak UIImageView *_imageView;
}

+ (instancetype)centerView;

/** 帖子数据模型 */
@property (nonatomic,strong)A3Topic *topic;
@end
