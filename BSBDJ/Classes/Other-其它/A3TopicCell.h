//
//  A3TopicCell.h
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class A3Topic;
@interface A3TopicCell : UITableViewCell

/** 帖子模型数据  */
@property (nonatomic,strong)A3Topic *topic;

@end
