//
//  A3TopicVideoView.m
//  BSBDJ
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3TopicVideoView.h"
#import "A3SeeBigViewController.h"
#import "A3Topic.h"
#import <UIImageView+WebCache.h>

@interface A3TopicVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation A3TopicVideoView

+ (instancetype)videoView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    //去除默认的autoresizingMask设置
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //监听图片点击
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(imageClick)]];

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

- (void)setTopic:(A3Topic *)topic
{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
@end
