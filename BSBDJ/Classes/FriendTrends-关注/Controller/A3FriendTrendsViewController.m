//
//  A3FriendTrendsViewController.m
//  BSBDJ
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3FriendTrendsViewController.h"
#import "A3RecommendFollowViewController.h"

@interface A3FriendTrendsViewController ()

@end

@implementation A3FriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = A3CommonBgColor;

    
    // 设置左上角
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecommentClick)];
}

- (void)friendsRecommentClick
{
    [self performSegueWithIdentifier:@"FriendTrends2RecommendFollow" sender:nil];
}

- (IBAction)backToFriendTrendsViewController:(UIStoryboardSegue *)segue
{
    A3Log(@"从%@控制器返回来的",segue.sourceViewController);
}
@end
