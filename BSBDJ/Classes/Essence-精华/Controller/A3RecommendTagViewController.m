//
//  A3RecommendTagViewController.m
//  BSBDJ
//
//  Created by mac on 15/11/5.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3RecommendTagViewController.h"
#import "A3HTTPSessionManager.h"
#import "A3RecommendTag.h"
#import "A3RecommendTagCell.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>

@interface A3RecommendTagViewController ()

/** 所有的标签数据(数组中存放的都是A3RecommendTag模型) */
@property (nonatomic,strong)NSArray *recommendTags;

/** 请求管理者 */
@property (nonatomic, weak) A3HTTPSessionManager *manager;
@end

@implementation A3RecommendTagViewController

#pragma mark - manager lazy
- (A3HTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [A3HTTPSessionManager manager];
    }
    return _manager;
}

/** cell的重用标识  */
static  NSString *const A3RecommendTagCellId = @"recommendTag";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([A3RecommendTagCell class]) bundle:nil] forCellReuseIdentifier:A3RecommendTagCellId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = A3CommonBgColor;
    
    //刷新控件
    __weak typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.header endRefreshing];
        });
    }];
    
    //加载标签数据
    [self loadNewRecommandTags];
    
}

/**
 *  加载标签数据
 */
- (void)loadNewRecommandTags
{
    //弱引用
    __weak typeof(self) weakSelf = self;
    
    //弹框
    [SVProgressHUD show];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]      = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"]      = @"topic";
    
    //发送请求
    [self.manager GET:A3RequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //字典数组 转 模型
        weakSelf.recommendTags = [A3RecommendTag objectArrayWithKeyValuesArray:responseObject];
        
        //刷新表格
        [weakSelf.tableView reloadData];
        
        //隐藏弹框
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        //如果是因为取消任务来到这个block,就直接返回
        if(error.code == NSURLErrorCancelled) return ;
        
        //提示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐标签数据失败"];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //隐藏弹框
    [SVProgressHUD dismiss];
    //取消当前的所有请求
    [self.manager invalidateSessionCancelingTasks:YES];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.recommendTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    A3RecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:A3RecommendTagCellId forIndexPath:indexPath];
    
    cell.recommendTag = self.recommendTags[indexPath.row];
    return cell;
}


@end
