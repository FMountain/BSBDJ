//
//  A3MeFooter.m
//  BSBDJ
//
//  Created by mac on 15/11/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3MeFooter.h"
#import "A3HTTPSessionManager.h"
#import <MJExtension.h>
#import "A3MeSquare.h"
#import "A3MeSquareButton.h"
#import "A3WebViewController.h"

@interface A3MeFooter()
@end

@implementation A3MeFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        __weak typeof(self) weakSelf = self;
        [[A3HTTPSessionManager manager] GET:A3RequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            // 字典数组 -> 模型数组
            NSArray *squares = [A3MeSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            // 根据模型数据创建方块
            [weakSelf createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
}

/**
 *  根据模型数据创建方块
 *
 *  @param squares 模型数据
 */
- (void)createSquares:(NSArray *)squares
{
    // 一共有多少列
    NSUInteger columnsCount = 4;
    
    NSUInteger count = squares.count;
    
    CGFloat buttonW = self.width / columnsCount;
    CGFloat buttonH = buttonW;
    
    for (NSUInteger i = 0; i < count; i++) {
        A3MeSquareButton *button = [A3MeSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 设置frame
        button.x = (i % columnsCount) * buttonW;
        button.y = (i / columnsCount) * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
        // 设置数据
        button.square = squares[i];
    }
    
    // 设置footer的高度 == 最后一个按钮的bottom
    self.height = self.subviews.lastObject.bottom;
    
    // 设置footer
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    
    //    tableView.contentSize = CGSizeMake(0, self.bottom);
}

- (void)buttonClick:(A3MeSquareButton *)button
{
    // 链接
    NSString *url = button.square.url;
    
    // 分情况处理
    if ([url hasPrefix:@"mod://"]) { // 特殊处理
        if ([url hasSuffix:@"BDJ_To_Check"]) {
            A3Log(@"跳转到Check控制器");
        } else if ([url hasSuffix:@"App_To_SearchUser"]) {
            A3Log(@"跳转到SearchUser控制器");
        }
    } else if ([url hasPrefix:@"http://"]) { // 利用webView来展示网页
        // 获得当前的导航控制器
        UITabBarController *root = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = root.selectedViewController;
        
        // push
        A3WebViewController *web = [[A3WebViewController alloc] init];
        web.url = url;
        web.navigationItem.title = button.square.name;
        [nav pushViewController:web animated:YES];
    } else {
        A3Log(@"其他");
    }
}
@end
