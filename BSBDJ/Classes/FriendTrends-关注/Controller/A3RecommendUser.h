//
//  A3RecommendUser.h
//  BSBDJ
//
//  Created by mac on 15/11/7.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface A3RecommendUser : NSObject
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;
/** 头像 */
@property (nonatomic, copy) NSString *header;
@end
