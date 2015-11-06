//
//  A3TopicVideoView.m
//  BSBDJ
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3TopicVideoView.h"
#import "A3Topic.h"
#import <UIImageView+WebCache.h>
#import <MediaPlayer/MediaPlayer.h>

@interface A3TopicVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
- (IBAction)videoClick:(UIButton *)sender;

/** 播放器 */
@property (nonatomic, strong) MPMoviePlayerController *player;
@end

@implementation A3TopicVideoView

- (void)setTopic:(A3Topic *)topic
{
    [super setTopic:topic];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
- (IBAction)videoClick:(UIButton *)sender {
    [self.player play];
}

#pragma mark - lazy
- (MPMoviePlayerController *)player
{
    if (_player == nil) {
        // 1.创建播放器
        _player = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.topic.videouri]];
        
        // 2.给播放器内部的View设置frame
        _player.view.frame =CGRectMake(0, 0,self.width, self.height);
        
        // 3.添加到控制器View中
        [self addSubview:_player.view];
        
        // 4.设置控制面板的显示
        _player.controlStyle = MPMovieControlStyleEmbedded;
    }
    return _player;
}

@end
