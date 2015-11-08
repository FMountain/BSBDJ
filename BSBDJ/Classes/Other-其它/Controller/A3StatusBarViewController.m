//
//  A3StatusBarViewController.m
//  BSBDJ
//
//  Created by mac on 15/11/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3StatusBarViewController.h"
@interface A3StatusBarViewController () <NSCopying>

@end
@implementation A3StatusBarViewController
#pragma mark - 单例
static id instance_;
+ (instancetype)sharedInstace
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
    });
    return instance_;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}

- (id)copyWithZone:(NSZone *)zone
{
    return instance_;
}

#pragma mark - window相关处理
static UIWindow *window_;
+ (void)show
{
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = [UIColor clearColor];
    window_.frame = [UIApplication sharedApplication].statusBarFrame;
    window_.hidden = NO;
    window_.windowLevel = UIWindowLevelAlert;
    window_.rootViewController = [[A3StatusBarViewController alloc] init];
    /*
     窗口级别:
     UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
     */
}

#pragma mark - 控制状态栏
- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}

#pragma mark - setter
//- (void)setShowingVc:(UIViewController *)showingVc
//{
//    _showingVc = showingVc;
//
//    [self setNeedsStatusBarAppearanceUpdate];
//}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;
    
    // 刷新状态栏 (内部会重新调用prefersStatusBarHidden和preferredStatusBarStyle方法)
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    _statusBarHidden = statusBarHidden;
    
    // 刷新状态栏 (内部会重新调用prefersStatusBarHidden和preferredStatusBarStyle方法)
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 让scrollView滚动到最前面
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

/**
 *  在view中搜索所有的scrollView
 */
- (void)searchScrollViewInView:(UIView *)view
{
    // 遍历所有的子控件
    for (UIView *subview in view.subviews) {
        [self searchScrollViewInView:subview];
    }
    
    // 如果是一个UIScrollView, 就进行滚动处理
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        
        // 计算出scrollView 以window左上角为坐标原点时的rect
        CGRect scrollViewRect = [scrollView convertRect:scrollView.bounds toView:nil];
        CGRect windowRect = scrollView.window.bounds;
        
        // 判断scrollView 跟 window 是否有重叠
        if (!CGRectIntersectsRect(windowRect, scrollViewRect)) return;
        
        // 滚动到最前面
        CGPoint offset = scrollView.contentOffset;
        offset.y = - scrollView.contentInset.top;
        [scrollView setContentOffset:offset animated:YES];
    }
}
@end
