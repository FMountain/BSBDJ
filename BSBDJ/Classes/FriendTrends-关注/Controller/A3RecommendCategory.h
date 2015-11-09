//
//  A3RecommendCategory.h
//  BSBDJ
//
//  Created by mac on 15/11/7.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface A3RecommendCategory : NSObject

/** 名字 */
@property (nonatomic,copy) NSString *name;
/** id */
@property (nonatomic,copy) NSString *id;

/** 用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
@end
