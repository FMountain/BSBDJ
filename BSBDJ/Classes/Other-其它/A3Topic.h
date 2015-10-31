//
//  A3Topic.h
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    /** 图片 */
    A3TopicTypePicture = 10,
    /** 文字 */
    A3TopicTypeWord = 29,
    /** 声音 */
    A3TopicTypeVoice = 31,
    /** 视频 */
    A3TopicTypeVideo = 41
    
} A3TopicType;

@interface A3Topic : NSObject
// 用户 -- 发帖者
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 帖子的类型 */
@property (nonatomic,assign)A3TopicType type;


@end
