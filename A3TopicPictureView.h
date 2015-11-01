//
//  A3TopicPictureView.h
//  BSBDJ
//
//  Created by mac on 15/11/1.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  A3Topic;

@interface A3TopicPictureView : UIView

+ (instancetype)pictureView;

/** 帖子模型数据 */
@property (nonatomic,strong)A3Topic *topic;
@end
