//
//  A3EssenceViewController.m
//  BSBDJ
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3EssenceViewController.h"
#import "A3TitleButton.h"

@interface A3EssenceViewController ()
/** 当前被选中的标题按钮 */

@property (nonatomic,weak) A3TitleButton *selectedTitleButton;
@end

@implementation A3EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //添加ScrollView
    [self setupScrollView];
    
    //添加ScrollView内的每个view的标题栏
    [self setupTitlesView];
    
}
/**
 *  设置导航栏
 */
- (void)setupNav
{
    // 设置标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置左上角
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(mainTagSubClick)];
}
/**
 *  添加ScrollView
 */
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = A3RandomColor;
    [self.view addSubview:scrollView];
}

/**
 *  添加ScrollView内的每个view的标题栏
 */
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
   //标题栏40 ,title 24
    titlesView.frame = CGRectMake(0, 64, self.view.frame.size.width, 40);
    //标题栏的透明度.
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    //添加到view
    [self.view addSubview:titlesView];
    
    //添加标题
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    // size
    CGFloat titleButtonW = titlesView.width / 5;
    CGFloat titleButtonH = titlesView.height;
    
    //遍历标题按钮
    for (int i = 0; i < 5; i++) {
        //创建
        A3TitleButton *titleButton  =[[A3TitleButton alloc]init];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        
        //frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        
        //设置
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        //font
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        //数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
}


- (void)mainTagSubClick
{
    A3LogFuc;
}

- (void)titleButtonClick:(A3TitleButton  *)titleButton
{
    A3LogFuc;
    //让当前被 选中的标题按钮恢复以前的状态 (取消选中)
    self.selectedTitleButton.selected = NO;
    
    //让被点击的按钮变成选中状态
    titleButton.selected = YES;
    
    //让被点击的标题按钮 -> 当前选中的标题按钮
    self.selectedTitleButton = titleButton;
}
@end
