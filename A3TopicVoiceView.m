//
//  A3TopicVoiceView.m
//  BSBDJ
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3TopicVoiceView.h"
#import "A3Topic.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>

@interface A3TopicVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
- (IBAction)voiceButton:(UIButton *)sender;

/** 播放器 */
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation A3TopicVoiceView


- (void)setTopic:(A3Topic *)topic
{
    [super setTopic:topic];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}


- (IBAction)voiceButton:(UIButton *)sender {
    [self.player play];
}


#pragma mark - lazy
- (AVPlayer *)player
{
    if (!_player) {
        AVPlayerItem  *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.topic.voiceuri]];
       
        //创建player对象
        _player = [[AVPlayer alloc] initWithPlayerItem:item];
    }
    return _player;
}
@end
