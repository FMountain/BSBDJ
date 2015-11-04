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

@interface A3TopicVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
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
@end
