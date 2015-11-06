//
//  A3EssenceViewController.m
//  BSBDJ
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3EssenceViewController.h"
#import "A3TitleButton.h"
#import "A3AllViewController.h"
#import "A3VideoViewController.h"
#import "A3VoiceViewController.h"
#import "A3PictureViewController.h"
#import "A3WordViewController.h"
#import "A3RecommendTagViewController.h"

@interface A3EssenceViewController ()<UIScrollViewDelegate>
/** 当前被选中的标题按钮 */
@property (nonatomic,weak) A3TitleButton *selectedTitleButton;

/** 标题下的指示器 */
@property (nonatomic, weak) UIView *titleIndicatorView;
/**存放所有子控制器的 scrollView */
@property (nonatomic,weak)UIScrollView *scrollView;
/**  存放所有的标题按钮 */
@property (nonatomic,strong)NSMutableArray *titleButtons;


@end

@implementation A3EssenceViewController

#pragma mark - lazy
- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加 子控制器
    [self setupChildVcs];
    
    //设置导航栏
    [self setupNav];
    
    //添加ScrollView
    [self setupScrollView];
    
    //添加ScrollView内的每个view的标题栏
    [self setupTitlesView];
    
    //根据scrollView的偏移量添加 子控制器的view
    [self addchildVcView];
    
}
/**
 *    根据scrollView的偏移量添加 子控制器的view
 */
- (void)addchildVcView
{
    UIScrollView *scrollView = self.scrollView;
    
    //计算按钮索引
    int index = scrollView.contentOffset.x / scrollView.width;
    
    //添加对应的子控制器view
    UIViewController *willShowVc = self.childViewControllers[index];
    
    if (willShowVc.isViewLoaded) return;
    
    [scrollView addSubview:willShowVc.view];
    
    willShowVc.view.frame = scrollView.bounds;
}
/**
 *  添加子控制器
 */
- (void)setupChildVcs
{
    A3AllViewController *all = [[A3AllViewController alloc] init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    A3VideoViewController *video = [[A3VideoViewController alloc] init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    A3VoiceViewController *voice =[[A3VoiceViewController alloc] init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    A3PictureViewController *picture = [[A3PictureViewController alloc] init];
    picture.title =@"图片";
    [self addChildViewController:picture];
    
    A3WordViewController *word = [[A3WordViewController alloc] init];
    word.title = @"段子";
    [self addChildViewController:word];
    
    
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
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //禁止掉 自动设置scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置内容大小
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.width, 0);
}


/**
 *  添加ScrollView内的每个view的标题栏
 */
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
   //标题栏40 ,title 24
    titlesView.frame = CGRectMake(0, A3NavBarBottom, self.view.width, A3TitlesViewH);
    //标题栏的透明度.
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    //添加到view
    [self.view addSubview:titlesView];
    
    //添加标题
//    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger count = self.childViewControllers.count;
    // size
    CGFloat titleButtonW = titlesView.width / count;
    CGFloat titleButtonH = titlesView.height;
    
    //遍历标题按钮
    for (int i = 0; i < count; i++) {
        //创建
        A3TitleButton *titleButton  =[[A3TitleButton alloc]init];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        
        //frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        
        //设置
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        //font
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        //数据
        [titleButton setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
    }
    //添加底部的指示器
    UIView *titleIndicatorView = [[UIView alloc] init];
    [titlesView addSubview:titleIndicatorView];
    //设置指示器的背景色为按钮的选中文字颜色
    A3TitleButton *firstTitleButton    = titlesView.subviews.firstObject;
    titleIndicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    titleIndicatorView.height          = 1;
    titleIndicatorView.bottom          = titlesView.height;
    self.titleIndicatorView            = titleIndicatorView;
    
    //默认行为 -> 选中firstTitleButton
    //让被 点击的标题按钮变成选中状态
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
    //sizeToFit :自动根据当前控件计算尺寸
    [firstTitleButton.titleLabel sizeToFit];
    
    //让指示器移动
    titleIndicatorView.width   = firstTitleButton.titleLabel.width;
    titleIndicatorView.centerX = firstTitleButton.centerX;
}

#pragma mark - 监听点击
- (void)mainTagSubClick
{
    A3RecommendTagViewController *tag = [[A3RecommendTagViewController alloc] init];
    [self.navigationController pushViewController:tag animated:YES];
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
    
    //让指示器移动
    [UIView animateWithDuration:0.25 animations:^{
        self.titleIndicatorView.width   = titleButton.titleLabel.width;
        self.titleIndicatorView.centerX = titleButton.centerX;
        
    }];
    //滚动scrollView
    CGPoint offset  = self.scrollView.contentOffset;
    offset.x = titleButton.tag  * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}
#pragma mark -  <UIScrollViewDelegate>
/**
 * setContentOffset:offset animated:YES 让scrollVieww[进行了滚动动画],那么最后
    会在停止滚动时调用 这个方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //根据 scrollView的偏移量添加子控制器的view
    [self addchildVcView];
}
/**
 *  当scrollView停上滚动的时候 会调用一次 (人为拖拽)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算按钮索引
    int index = scrollView.contentOffset.x / scrollView.width;
    A3TitleButton *titleButton = self.titleButtons[index];
    //点击按钮
    [self titleButtonClick:titleButton];
    
    //根据scrollView的偏移量添加子控制器的view
    [self addchildVcView];
}
@end
