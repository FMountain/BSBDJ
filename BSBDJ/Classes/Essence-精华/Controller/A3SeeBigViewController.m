//
//  A3SeeBigViewController.m
//  BSBDJ
//
//  Created by mac on 15/11/3.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3SeeBigViewController.h"
#import "A3Topic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface A3SeeBigViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak)UIImageView *imageView;
@end

@implementation A3SeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //scrollView
    UIScrollView *scrollView = [[UIScrollView alloc ]init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    //imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    imageView.width = scrollView.width;
    imageView.height = self.topic.height * imageView.width / self.topic.width;
    imageView.x = 0;
    if (imageView.height >= scrollView.height) {
        //图片高度超过整个屏幕
        imageView.y = 0;
        
    }else {
        //居中显示
        imageView.centerY = scrollView.height * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //滚动范围
    scrollView.contentSize = CGSizeMake(0, imageView.height);
    
    //缩放比例
    CGFloat maxScale = self.topic.height / imageView.height;
    
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
    }
    
}

- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save{
//存储图片到 相机胶卷
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
#pragma mark - UIScrollViewDelegate
/**
 *  返回一个 scrollView内部的子控件进行缩放
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return  self.imageView;
}
@end
