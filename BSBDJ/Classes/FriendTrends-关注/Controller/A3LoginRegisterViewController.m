//
//  A3LoginRegisterViewController.m
//  BSBDJ
//
//  Created by mac on 15/11/6.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3LoginRegisterViewController.h"

@interface A3LoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation A3LoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 *  设置顶部状态栏样式
 *
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    //白色
    return  UIStatusBarStyleLightContent;
}
- (IBAction)loginOrRegister:(UIButton *)button {
    //修改按钮的选中状态
    button.selected = !button.isSelected;
    
    //修改约束
    if(self.leftMargin.constant)
    {
        self.leftMargin.constant= 0;
        
    }else{
        self.leftMargin.constant = - self.view.width;
    }
    //执行动画
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    //退出键盘
    [self.view endEditing:YES];
}
//点击空白处退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
