//
//  A3TabBarController.m
//  BSBDJ
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3TabBarController.h"
#import "A3EssenceViewController.h"
#import "A3FriendTrendsViewController.h"
#import "A3MeViewController.h"
#import "A3NewViewController.h"

@interface A3TabBarController ()

@end

@implementation A3TabBarController
#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
//    UIViewController *vc0 = [[UIViewController alloc] init];
//    vc0.view.backgroundColor = [UIColor redColor];
//    vc0.tabBarItem.title = @"精华";
//    vc0.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
//    vc0.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabBar_essence_click_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//最原始的显示方式不改变图片
//    [self addChildViewController:vc0];

    //添加所有的子控制器
    [self setupChildVcs];
   
}

#pragma mark - 添加所有的子控制器
- (void)setupChildVcs
{
    [self setupOneChildVc:[[UINavigationController alloc] initWithRootViewController:[[A3EssenceViewController alloc] init]] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    //新贴
    [self setupOneChildVc:[[UINavigationController alloc]initWithRootViewController:[[A3NewViewController alloc] init]] title:@"新贴" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    //关注
    [self setupOneChildVc:[[UINavigationController alloc] initWithRootViewController:[[A3FriendTrendsViewController alloc] init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    //我
    [self setupOneChildVc:[[UINavigationController alloc] initWithRootViewController:[[A3MeViewController alloc] init]] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}
/**
 *  添加一个子控制器
 *  @param vc            控制器
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中的图标
 */
- (void)setupOneChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.view.backgroundColor = A3RandomColor;//随机背景色
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:vc];
}
@end
