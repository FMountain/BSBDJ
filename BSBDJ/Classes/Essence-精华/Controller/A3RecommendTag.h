//
//  A3RecommendTag.h
//  BSBDJ
//
//  Created by mac on 15/11/5.
//  Copyright © 2015年 mac. All rights reserved.
//RecommendTag 推荐连接

#import <Foundation/Foundation.h>

@interface A3RecommendTag : NSObject

/** 名字 */
@property (nonatomic,copy)NSString *theme_name;
/** 图片 */
@property (nonatomic,copy)NSString *image_list;
/** 订阅数 */
@property (nonatomic,assign)NSInteger sub_number;
@end
