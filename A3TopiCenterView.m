//
//  A3TopiCenterView.m
//  BSBDJ
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3TopiCenterView.h"
#import "A3SeeBigViewController.h"
@interface A3TopiCenterView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation A3TopiCenterView

+ (instancetype)centerView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    //去除默认的 autoresizingMask 设置
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //监听图片点击
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
}
- (void)imageClick
{
    if (self.imageView.image == nil) {
        return;
    }
    
    A3SeeBigViewController *seeBig = [[A3SeeBigViewController alloc] init];
    seeBig.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBig animated:YES completion:nil];
}
@end
