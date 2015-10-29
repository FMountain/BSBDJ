//
//  A3EssenceViewController.m
//  BSBDJ
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3EssenceViewController.h"

@interface A3EssenceViewController ()

@end

@implementation A3EssenceViewController

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
