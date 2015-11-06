//
//  A3Topic.h
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class A3Comment;

typedef enum{
    /** 全部 */
    A3TopicTypeAll = 1,
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
/** 最热评论 */
@property (nonatomic,strong)A3Comment *top_cmt;
/** 图片的宽度 */
@property (nonatomic,assign)CGFloat width;
/** 图片的高度 */
@property (nonatomic,assign)CGFloat height;
/** 小图 */
@property (nonatomic,copy)NSString *small_image;
/** 中图 */
@property (nonatomic,copy)NSString *middle_image;
/** 大图 */
@property (nonatomic,copy)NSString *large_image;
/** 是否为动态图 */
@property (nonatomic,assign)BOOL is_gif;
/** 播放数量 */
@property (nonatomic,assign)NSInteger playcount;
/** 声音文件的长度 */
@property (nonatomic,assign)NSInteger voicetime;
/** 视频文件的长度 */
@property (nonatomic,assign)NSInteger videotime;
//辅助属性
/** 中间控件的frame */
@property (nonatomic,assign)CGRect centerViewFrame;;
/** 自定义cell的高度 */
@property (nonatomic,assign)CGFloat cellHeight;

/** 是否为大图 */
@property (nonatomic,assign,getter=isBigPicture)BOOL bigPicture;

/** 声音地址 */
@property (nonatomic,copy)NSString *voiceuri;
/** 视频地址 */
@property (nonatomic,copy)NSString *videouri;
@end
