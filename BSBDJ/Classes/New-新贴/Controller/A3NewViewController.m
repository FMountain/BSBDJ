//
//  A3NewViewController.m
//  BSBDJ
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3NewViewController.h"

@interface A3NewViewController ()

@end

@implementation A3NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置左上角
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(mainTagSubClick)];
}

- (void)mainTagSubClick
{
    A3LogFuc;
}

@end
