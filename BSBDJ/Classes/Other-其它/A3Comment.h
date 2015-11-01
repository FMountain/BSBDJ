//
//  A3Comment.h
//  BSBDJ
//
//  Created by mac on 15/10/31.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class A3User;
@interface A3Comment : NSObject
/** 评论内容 */
@property (nonatomic,copy)NSString *content;
/** 发表这条评论的用户 */
@property (nonatomic,strong)A3User *user;
@end
