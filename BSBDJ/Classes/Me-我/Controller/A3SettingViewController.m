//
//  A3SettingViewController.m
//  BSBDJ
//
//  Created by mac on 15/11/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3SettingViewController.h"
#import <SDImageCache.h>
#import "A3ClearCacheCell.h"
#import "A3SettingCell.h"
#import "A3OtherCell.h"

@interface A3SettingViewController ()

@end

@implementation A3SettingViewController

static NSString * const A3ClearCacheCellId = @"clear_cache";
static NSString * const A3SettingCellId = @"setting";
static NSString * const A3OtherCellId = @"other";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    // 注册
    [self.tableView registerClass:[A3ClearCacheCell class] forCellReuseIdentifier:A3ClearCacheCellId];
    [self.tableView registerClass:[A3SettingCell class] forCellReuseIdentifier:A3SettingCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([A3OtherCell class]) bundle:nil] forCellReuseIdentifier:A3OtherCellId];
    
    self.tableView.backgroundColor = A3CommonBgColor;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { // 清除缓存
        
            return [tableView dequeueReusableCellWithIdentifier:A3ClearCacheCellId];
        } else { // 其他cell
            A3SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:A3SettingCellId];
            
            if (indexPath.row == 1) {
                cell.textLabel.text = @"检查更新";
            } else if (indexPath.row == 2) {
                cell.textLabel.text = @"给我们评分";
            } else if (indexPath.row == 3) {
                cell.textLabel.text = @"推送设置";
            } else {
                cell.textLabel.text = @"关于我们";
            }
            
            return cell;
        }
    } else {
        return [tableView dequeueReusableCellWithIdentifier:A3OtherCellId];
    }
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    A3LogFuc;
}
@end