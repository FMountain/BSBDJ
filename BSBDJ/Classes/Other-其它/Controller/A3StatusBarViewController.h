//
//  A3StatusBarViewController.h
//  BSBDJ
//
//  Created by mac on 15/11/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface A3StatusBarViewController : UIViewController
+ (void)show;

+ (instancetype)sharedInstace;

/** 状态的显示和隐藏 */
@property (nonatomic, assign, getter=isStatusBarHidden) BOOL statusBarHidden;
/** 状态栏的样式 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/** 正在显示的控制器 */
//@property (nonatomic, weak) UIViewController *showingVc;
@end
