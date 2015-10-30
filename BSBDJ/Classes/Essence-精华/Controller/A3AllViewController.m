//
//  A3AllViewController.m
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3AllViewController.h"
#import "A3TopicCell.h"
#import "A3HTTPSessionManager.h"
#import <MJExtension.h>
#import "A3Topic.h"

@interface A3AllViewController ()
/** 请求管理者 */
@property (nonatomic,weak)A3HTTPSessionManager *manager;

/** 帖子数据 */
@property (nonatomic,strong)NSArray *topics;
@end

@implementation A3AllViewController

static NSString *const A3TopicCellId = @"topic";

#pragma mark - lazy
- (A3HTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [A3HTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(A3NavBarBottom + A3TitlesViewH, 0, A3TabBarH, 0 );
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.rowHeight = 200;
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([A3TopicCell class]) bundle:nil] forCellReuseIdentifier:A3TopicCellId];
    
    //加载 帖子数据
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]    = @"list";
    params[@"type"] = @"1";
    params[@"c"]    = @"data";
    
    //发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:A3RequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //字典数组 ->模型数组
        weakSelf.topics = [A3Topic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        A3Log(@"请求数据失败");
    }];
}

#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    A3TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:A3TopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    return cell;
}
@end
