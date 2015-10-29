//
//  A3FriendTrendsViewController.m
//  BSBDJ
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3FriendTrendsViewController.h"

@interface A3FriendTrendsViewController ()

@end

@implementation A3FriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.navigationItem.title = @"我的关注";
    
    // 设置左上角
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecommentClick)];
}

- (void)friendsRecommentClick
{
    A3LogFuc;
}
@end
