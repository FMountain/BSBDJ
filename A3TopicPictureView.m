//
//  A3TopicPictureView.m
//  BSBDJ
//
//  Created by mac on 15/11/1.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3TopicPictureView.h"
#import "A3Topic.h"
#import <UIImageView+WebCache.h>
#import "A3SeeBigViewController.h"
#import <DALabeledCircularProgressView.h> //下载进度圆条

@interface A3TopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@end

@implementation A3TopicPictureView

+ (instancetype)pictureView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    //去除默认的autoresizingMask设置
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //初始化
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    //监听图片点击
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
}

- (void)imageClick
{
    if (self.imageView.image == nil) return;
    
    A3SeeBigViewController *seeBig = [[A3SeeBigViewController alloc] init];
    seeBig.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBig animated:YES completion:nil];
}

- (void)setTopic:(A3Topic *)topic
{
    _topic = topic;
    //显示图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //显示正在下载的提醒
        self.progressView.hidden = NO;
        self.placeholderView.hidden = NO;
        
        //显示进度值
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        
        //progress = 0.79 79%
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //下载完毕
        //隐藏正在下载的提醒
        self.placeholderView.hidden = YES;
        self.progressView.hidden = YES;
    }];
    //是否为gif
    self.gifView.hidden = !topic.is_gif;
    //查看大图
    self.seeBigButton.hidden = !topic.isBigPicture;
    if (topic.isBigPicture) {
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}
@end
