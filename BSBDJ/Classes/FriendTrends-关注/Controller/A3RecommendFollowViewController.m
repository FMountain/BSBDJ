//
//  A3RecommendFollowViewController.m
//  BSBDJ
//
//  Created by mac on 15/11/7.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3RecommendFollowViewController.h"
#import "A3RecommendCategory.h"
#import "A3RecommendCategoryCell.h"
#import "A3HTTPSessionManager.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import "A3RecommendUser.h"
#import "A3RecommenduserCell.h"

@interface A3RecommendFollowViewController() <UITableViewDataSource,UITableViewDelegate>
//类别表格
@property (weak, nonatomic) IBOutlet UITableView *categoryTable;
/** 👉 - 用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTable;
/** 请求管理者 */
@property (nonatomic, weak) A3HTTPSessionManager *manager;
/** 👈 - 所有的类别数据 */
@property (nonatomic, strong) NSArray<A3RecommendCategory *> *categories;

/** 👉 - 用户数据 */
@property (nonatomic, strong) NSArray<A3RecommendUser *> *users;
@end

@implementation A3RecommendFollowViewController

#pragma mark - lazy
- (A3HTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [A3HTTPSessionManager manager];
    }
    return _manager;
}

/** cell的重用标识 */
static NSString * const A3CategoryCellId = @"category";
static NSString * const A3UserCellId = @"user";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = A3CommonBgColor;
    //设置表格
    [self setupTable];
  
    //加载 类别表格 数据
    [self loadCategories];
}
   //设置表格
 - (void)setupTable
{
 
    UIEdgeInsets inset = UIEdgeInsetsMake(A3NavBarBottom, 0, 0, 0);
    self.categoryTable.contentInset = inset;
    self.categoryTable.scrollIndicatorInsets = inset;
    
//    self.userTable.contentInset = inset;
    self.userTable.scrollIndicatorInsets = inset;
    //下拉刷新
    self.userTable.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    //上拉刷新
    self.userTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
   
}
#pragma mark - 加载数据
/**
 *  加载更多的用户数据
 */
- (void)loadMoreUsers
{
    //取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //当前选中的类别模型
    A3RecommendCategory *category = self.categories[self.categoryTable.indexPathForSelectedRow.row];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = category.id;
    
    //发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:A3RequestURL  parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //字典数组 - >模型数组
        NSArray *moreUsers = [A3RecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //更多数据加载在尾部
        [category.users addObjectsFromArray:moreUsers];
        
        //刷新 用户表格
        [weakSelf.userTable reloadData];
        //结束刷新
        if (category.users.count == category.total) {
            
            weakSelf.userTable.footer.hidden  = YES;
        }else{
            [weakSelf.userTable.footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        A3Log(@"请求失败");
        //结束刷新
        [weakSelf.userTable.header endRefreshing];
        
    }];
}

/**
 *  加载最新的用户数据
 */
- (void)loadNewUsers
{
    //取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //当前选中的类别模型
    A3RecommendCategory * category = self.categories[self.categoryTable.indexPathForSelectedRow.row];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = category.id;
    
    //发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:A3RequestURL  parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //字典数组 - >模型数组
        weakSelf.users = [A3RecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新 用户表格
        [weakSelf.userTable reloadData];
        //结束刷新
        [weakSelf.userTable.header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        A3Log(@"请求失败");
        //结束刷新
        [weakSelf.userTable.header endRefreshing];

    }];
}
/**
 *  加载 👈 - 类别表格 数据
 */
- (void)loadCategories
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    //发送请求
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:A3RequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //字典数组 -> 模型数组
        weakSelf.categories = [A3RecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新 类别表格
        [weakSelf.categoryTable reloadData];
        
        //选中第0行
        [weakSelf.categoryTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //打开自动刷新
        [weakSelf.userTable.header beginRefreshing];
        
        //隐藏
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        //
        [SVProgressHUD dismiss];
    }];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTable) {
        //类别表格
        return self.categories.count;
    }else{//用户表格
        return self.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTable) {
        A3RecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:A3CategoryCellId];
        
        cell.category = self.categories[indexPath.row];
         return cell;
    }else{ //用户表格
    
        A3RecommenduserCell *cell = [tableView dequeueReusableCellWithIdentifier:A3UserCellId];
        
        cell.user = self.users[indexPath.row];
        return cell;
    }
   
}

#pragma mark - Table View delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTable) {
        // 进入下拉刷新状态 (加载最新的用户数据)
        [self.userTable.header beginRefreshing];
    }else{
        A3Log(@"didSelectRow 👉 - 用户表格---%zd", indexPath.row);
    }
}
@end
