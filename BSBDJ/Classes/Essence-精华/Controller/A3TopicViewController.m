//
//  A3TopicViewController.m
//  BSBDJ
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 mac. All rights reserved.
//

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
#import <MJRefresh.h>
#import "A3Topic.h"

#import "A3NewViewController.h"

@interface A3TopicViewController ()
/** 请求管理者 */
@property (nonatomic,weak)A3HTTPSessionManager *manager;

/** 帖子数据 */
@property (nonatomic,strong)NSMutableArray<A3Topic *> *topics;

/** 加载下一页数据的参数 */
@property (nonatomic,copy)NSString *maxtime;
@end

@implementation A3TopicViewController

- (A3TopicType)type {return 0;}
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
    
    //设置tableView
    [self setupTable];
    //增加刷新控件  加载数据
    [self setupRefresh];
}

- (void)setupTable
{
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(A3NavBarBottom + A3TitlesViewH, 0, A3TabBarH + A3Margin, 0 );
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.rowHeight = 200;
    
    //没有分隔符 背景和Cell之间的间距 作分隔符
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = A3CommonBgColor;
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([A3TopicCell class]) bundle:nil] forCellReuseIdentifier:A3TopicCellId];
    
}
#pragma mark - 刷新
- (void)setupRefresh
{
    //header - 下拉
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic) ];
    
    
    //进入刷新状态
    [self.tableView.header beginRefreshing];
    
    //自动调整透明度,隐藏刷新控件.
    self.tableView.header.automaticallyChangeAlpha = YES;
    //上拉
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    //    [self.tableView.footer beginRefreshing];
}
#pragma mark - 数据处理
/**
 *  参数a
 *
 *  @return newlist / list
 */
- (NSString *)paramA
{
    //isKindOfClass :判断是否为这种类类型或者是这种类型的子类
    if ([self.parentViewController isKindOfClass:[A3NewViewController class]])
    {
        return @"newlist";
    }
    return @"list";
}

//加载 帖子数据
- (void)loadNewTopic
{
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"]       = self.paramA;
    params[@"type"]    = @(self.type);
    params[@"c"]       = @"data";
    
    //发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:A3RequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //看第几个帖子有最热评论
        int i = 0;
        NSArray *dictArray = responseObject[@"list"];
        for (NSMutableDictionary *dict in dictArray) {
            NSArray *top_cmt = dict[@"top_cmt"];
            if (top_cmt.count) {
                A3Log(@"第%zd个帖子有最热评论",i);
            }
            i++;
        }
        //存储maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 ->模型数组
        weakSelf.topics = [A3Topic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [weakSelf.tableView reloadData];
        
        //结束刷新
        [weakSelf.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        A3Log(@"请求数据失败");
        //结束刷新
        [weakSelf.tableView.header endRefreshing];
    }];
    
}
//加载更多 的帖子数据
- (void)loadMoreTopic
{
    //请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"]       = self.paramA;
    params[@"type"]    = @(self.type);
    params[@"c"]       = @"data";
    params[@"maxtime"] = self.maxtime;
    
    //发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:A3RequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //看第几个帖子有最热评论
        int i = 0;
        NSArray *dictArray = responseObject[@"list"];
        for (NSMutableDictionary *dict in dictArray) {
            NSArray *top_cmt = dict[@"top_cmt"];
            if (top_cmt.count) {
                A3Log(@"第%zd个帖子有最热评论",i);
            }
            i++;
        }
        
        //存储maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 ->模型数组
        NSArray *moreTopics = [A3Topic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //增加到以前数组的最后面
        [weakSelf.topics addObjectsFromArray:moreTopics];
        
        //刷新表格
        [weakSelf.tableView reloadData];
        
        //结束刷新
        [weakSelf.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        A3Log(@"请求数据刷新失败");
        //结束刷新
        [weakSelf.tableView.footer endRefreshing];
        
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

#pragma mark - 代理方法 调整cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}


@end
