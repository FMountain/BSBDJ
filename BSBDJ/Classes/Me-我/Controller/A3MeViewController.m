//
//  A3MeViewController.m
//  BSBDJ
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//
#import "A3MeViewController.h"
#import "A3SettingViewController.h"
#import "A3MeCell.h"
#import "A3MeFooter.h"

@interface A3MeViewController ()

@end

@implementation A3MeViewController

static NSString * const A3MeCellId = @"me";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置表格
    [self setupTable];
    
    // 设置导航栏
    [self setupNav];
}

/**
 *  设置表格
 */
- (void)setupTable
{
    self.tableView.backgroundColor = A3CommonBgColor;
    [self.tableView registerClass:[A3MeCell class] forCellReuseIdentifier:A3MeCellId];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = A3Margin;
    self.tableView.contentInset = UIEdgeInsetsMake(A3Margin - A3GorupFirstCellY, 0, 0, 0);
    
    // 设置footer
    self.tableView.tableFooterView = [[A3MeFooter alloc] init];
}

/**
 *  设置导航栏
 */
- (void)setupNav
{
    // 设置标题
    self.navigationItem.title = @"我的";
    // 设置右上角
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

#pragma mark - 监听
- (void)moonClick
{
    A3LogFuc;
}

- (void)settingClick
{
    A3SettingViewController *setting = [[A3SettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:setting animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    A3MeCell *cell = [tableView dequeueReusableCellWithIdentifier:A3MeCellId];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
    } else {
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil; // 写上这句会更加严谨
    }
    
    return cell;
}

@end
